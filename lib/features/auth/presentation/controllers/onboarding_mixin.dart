part of 'package:tmed_kiosk/features/auth/presentation/views/phone_onboarding.dart';

mixin OnboardingMixin on State<PhoneOnboarding> {
  DateTime dateTime = DateTime.now();
  final pageController = PageController(initialPage: 0);
  double currentPage = 0;
  List<Widget> pages = [];
  final List<FlagEntity> lengu = [
    FlagEntity(icon: AppImages.ruFlag, name: "Русский", type: 'ru'),
    FlagEntity(icon: AppImages.uzFlag, name: "Uzbek", type: 'uz'),
    // FlagEntity(icon: AppImages.uzFlag, name: "Engilish"),
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  late ValueNotifier<FlagEntity> selectedItem;

  getLenguage() async {
    final lenguage =
        StorageRepository.getString(StorageKeys.LANGUAGE, defValue: "ru");
    if (lenguage == "uz") {
      selectedItem = ValueNotifier<FlagEntity>(lengu[1]);
    } else {
      selectedItem = ValueNotifier<FlagEntity>(lengu[0]);
    }
  }

  @override
  void initState() {
    selectedItem = ValueNotifier<FlagEntity>(lengu[0]);
    getLenguage();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
