package sist.last.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sist.last.dto.RoomDto;
import sist.last.mapper.RoomMapperInter;

@Controller
public class RoomController {

    @Autowired
    RoomMapperInter mapper;

    @GetMapping("/room/room-list")
    public ModelAndView list(@RequestParam String accom_num) {

        ModelAndView model = new ModelAndView();

        int totalCount = mapper.getTotalCount(accom_num);
        List<RoomDto> list = mapper.getAllData();

        model.addObject("totalCount", totalCount);
        model.addObject("list", list);

        model.setViewName("/room/roomList");

        return model;
    }

    @GetMapping("/room/room-insert")
    public String roominsertform() {
        return "/room/roomInsert";
    }

    @PostMapping("/room/insert")
    public String insert(@ModelAttribute RoomDto dto, MultipartFile photo, HttpSession session,
                         @RequestParam String[] checkin, @RequestParam String[] checkout) {
        // save 위치
        String path = session.getServletContext().getRealPath("/roomsave");

        // 업로드한 파일 dto 얻기
        String originalFilename = photo.getOriginalFilename();
        // 파일 이름에 날짜 및 시간 추가
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String timestamp = sdf.format(new Date());
        String newFilename = timestamp + "_" + originalFilename;
        dto.setRoom_photo(newFilename);

        try {
            photo.transferTo(new File(path + "/" + newFilename));
        } catch (IllegalStateException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        mapper.insertRoom(dto);

        return "redirect:/room/room-list";
    }

    @GetMapping("/room/delete")
    public String delete(@RequestParam int num, HttpSession session) {

        RoomDto dto = mapper.getOneData(num);

        //AccomDto가 null이 아닌지 확인
        if (dto != null) {
            // 기존 이미지 파일 삭제
            String oldFilename = dto.getRoom_photo();
            if (oldFilename != null && !oldFilename.isEmpty()) {
                String path = session.getServletContext().getRealPath("/roomsave");
                File oldFile = new File(path, oldFilename);

                //파일이 존재하고 삭제에 성공한 경우에만 삭제
                if (oldFile.exists() && oldFile.delete()) {
                    System.out.println("기존 이미지 파일 삭제 성공");
                } else {
                    System.out.println("기존 이미지 파일 삭제 실패");
                }
            }
        }

        mapper.deleteRoom(num);

        return "redirect:/room/room-list";

    }

    @GetMapping("/room/room-update")
    public String accomupdatefrom(@RequestParam int num, Model model) {
        RoomDto dto = mapper.getOneData(num);

        model.addAttribute("dto", dto);

        return "/room/roomUpdate";
    }

    @PostMapping("/room/update")
    public String update(@ModelAttribute RoomDto dto, MultipartFile photo, HttpSession session) {

        // save 위치
        String path = session.getServletContext().getRealPath("/roomsave");
        // 업로드한 파일 dto 얻기
        String originalFilename = photo.getOriginalFilename();
        // 파일 이름에 날짜 및 시간 추가
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
        String timestamp = sdf.format(new Date());
        String newFilename = timestamp + "_" + originalFilename;
        // 파일 삭제
        String oldFilename = mapper.getOneData(dto.getRoom_num()).getRoom_photo();
        try {
            // 기존 이미지 파일 삭제
            File oldFile = new File(path + "/" + oldFilename);
            oldFile.delete();

            // 신규 이미지 파일 저장
            photo.transferTo(new File(path + "/" + newFilename));

            // 새 파일 이름 설정
            dto.setRoom_photo(newFilename);

        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
        }

        mapper.updateRoom(dto);

        return "redirect:/room/room-list";
    }

    /*@ResponseBody
    @GetMapping("/room/duplicate-date")
    public Map<String, String> duplicateDate(@RequestParam("checkin") String[] checkin,
                                             @RequestParam("checkout") String[] checkout,
                                             @RequestParam("idx") int[] idx) {
        Map<String, String> map = new HashMap<>();
        // 필요한 로직을 수행하고 응답을 반환합니다.
        StringBuilder sb = new StringBuilder();
        int flag = 0;
        for (int i = 0; i < checkin.length; i++) {
            LocalDate checkinDate = LocalDate.parse(checkin[i]);
            LocalDate checkoutDate = LocalDate.parse(checkout[i]);

            // 중복 검사
            if (isDateRangeOverlap(checkinDate, checkoutDate, checkin, checkout, i)) {
                sb.append(i).append(",");
                flag = 1;
            }
            if (flag == 1) {
                sb.delete(sb.length() - 1, sb.length());
            }
        }
        map.put("index", sb + "가 중복됨");
        map.put("flag", flag + "");
        return map;
    }

    private boolean isDateRangeOverlap(LocalDate newCheckin, LocalDate newCheckout, String[] checkinList,
                                       String[] checkoutList, int currentIndex) {
        for (int i = 0; i < checkinList.length; i++) {
            if (i != currentIndex) {
                LocalDate existingCheckin = LocalDate.parse(checkinList[i]);
                LocalDate existingCheckout = LocalDate.parse(checkoutList[i]);

                // 새로운 체크인 날짜가 기존 기간에 포함되거나
                // 새로운 체크아웃 날짜가 기존 기간에 포함되는 경우 중복으로 처리
                if ((newCheckin.isEqual(existingCheckin) || newCheckin.isAfter(existingCheckin)) &&
                        (newCheckin.isBefore(existingCheckout) || newCheckin.isEqual(existingCheckout)) ||
                        (newCheckout.isEqual(existingCheckin) || newCheckout.isAfter(existingCheckin)) &&
                                (newCheckout.isBefore(existingCheckout) || newCheckout.isEqual(existingCheckout))) {
                    return true; // 중복이 발생했음
                }
            }
        }
        return false; // 중복이 없음
    }*/

}