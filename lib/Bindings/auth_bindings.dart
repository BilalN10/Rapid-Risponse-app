import 'package:get/get.dart';
import 'package:rapid_response/Controller/guards_and_commitee_member_controller.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    //Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UserAthenticationController>(UserAthenticationController());
    Get.put<GuardsandMemberController>(GuardsandMemberController());

    // Get.put<PracController>(PracController());
    // Get.put<ClientController>(ClientController());
    //Get.put<ConfirmClientsController>(ConfirmClientsController());
  }
}
