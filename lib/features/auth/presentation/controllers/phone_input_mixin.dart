part of 'package:tmed_kiosk/features/auth/presentation/views/phone_input_view.dart';

mixin PhoneInputMixin on State<PhoneInputView> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController password;
  bool isCheckEmail = false;
  bool isCheckPas = false;
  final List<FlagEntity> lengu = [
    FlagEntity(icon: AppImages.ruFlag, name: "Русский", type: 'ru'),
    FlagEntity(icon: AppImages.uzFlag, name: "Uzbek", type: 'uz'),
    // FlagEntity(icon: AppImages.uzFlag, name: "Engilish"),
  ];
  late ValueNotifier<FlagEntity> selectedItem;

  getLenguage() async {
    final lenguage =
        StorageRepository.getString(StorageKeys.LANGUAGE, defValue: "ru");
    if (lenguage == "ru") {
      selectedItem = ValueNotifier<FlagEntity>(lengu[0]);
    } else {
      selectedItem = ValueNotifier<FlagEntity>(lengu[1]);
    }
  }

  @override
  void initState() {
    username = TextEditingController();
    password = TextEditingController();
    selectedItem = ValueNotifier<FlagEntity>(lengu[0]);
    getLenguage();
    super.initState();
  }

  login() {
    if (formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
            LoginUser(
              onError: (text) {
                isCheckEmail = true;
                isCheckPas = true;
                var error = text;
                if (error.toLowerCase().contains('dio') ||
                    error.toLowerCase().contains('type')) {
                  error = "User Topilmadi";
                } else if (error.toLowerCase().contains('user')) {
                  error = "User Topilmadi";
                }
                context.read<ShowPopUpBloc>().add(ShowPopUp(
                      message: error,
                      status: PopStatus.error,
                    ));
              },
              password: password.text,
              userName: username.text,
              onSuccess: () {
                // StorageRepository.putString(
                //   StorageKeys.COMPID,

                // );
              },
            ),
          );
    }
  }
}
