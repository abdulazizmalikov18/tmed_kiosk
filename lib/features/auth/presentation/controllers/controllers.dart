part of 'package:tmed_kiosk/features/auth/presentation/views/auth_main_view.dart';

mixin AuthMainMixin on State<AuthMainView> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController compController;
  bool isCheckEmail = false;
  bool isCheckPas = false;
  final List<FlagEntity> lengu = [
    FlagEntity(icon: AppImages.ruFlag, name:  LocaleKeys.language_ru.tr(), type: 'ru'),
    FlagEntity(icon: AppImages.uzFlag, name:  LocaleKeys.language_uz.tr() ,type: 'uz'),
    FlagEntity(icon: AppImages.engFlag, name:  LocaleKeys.language_en.tr(), type: 'en'),
  ];
  late ValueNotifier<FlagEntity> selectedItem;
  getLenguage() async {
    final lenguage =
    StorageRepository.getString(StorageKeys.LANGUAGE, defValue: "ru");
    if (lenguage == "uz") {
      selectedItem = ValueNotifier<FlagEntity>(lengu[1]);
    } else  if (lenguage == "en") {
      selectedItem = ValueNotifier<FlagEntity>(lengu[2]);
    } else {
      selectedItem = ValueNotifier<FlagEntity>(lengu[0]);
    }
  }

  @override
  void initState() {
    getLenguage();
    username = TextEditingController();
    password = TextEditingController();
    compController = TextEditingController();
    UserType.none.putStorage();
    super.initState();
  }

  bool isBtmSheetOpened = false;

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
              onSuccess: () {},
            ),
          );
    }
  }
}
