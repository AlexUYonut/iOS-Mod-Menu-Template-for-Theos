#import "Macros.h"

/******************************************************************
  ADRESE EXTRASE PENTRU ONESTATE RP
  Aimbot Rotation: 0x47281e3
  God Mode: 0x462d525
  ESP Position: 0x471d161
******************************************************************/

void setup() {

  // Patch-uri directe (fără switch) - Exemplu pentru stabilitate
  patchOffset(ENCRYPTOFFSET("0x472f65d"), ENCRYPTHEX("0x1F2003D5")); // NOP la Rigidbody set_rotation pentru stabilitate

  // 1. GOD MODE (Nemurire)
  [switches addOffsetSwitch:NSSENCRYPT("God Mode")
    description:NSSENCRYPT("Te face nemuritor pe server")
    offsets: {
        ENCRYPTOFFSET("0x462d525") // Offset-ul de Health găsit la linia 46
    }
    bytes: {
        ENCRYPTHEX("0x00E0BF12C0035FD6") // Patch standard pentru înghețare viață
    }
  ];

  // 2. AIMBOT (Doar la țintă)
  [switches addOffsetSwitch:NSSENCRYPT("Aimbot (On Sight)")
    description:NSSENCRYPT("Se activează automat când pui ținta")
    offsets: {
        ENCRYPTOFFSET("0x47281e3") // Offset set_rotation de la linia 6
    }
    bytes: {
        ENCRYPTHEX("0x20008052C0035FD6") // Patch pentru forțarea rotației
    }
  ];

  // 3. ESP POSITION
  [switches addOffsetSwitch:NSSENCRYPT("Show Players ESP")
    description:NSSENCRYPT("Vezi locația jucătorilor prin pereți")
    offsets: {
        ENCRYPTOFFSET("0x471d161") // Offset get_position de la linia 39
    }
    bytes: {
        ENCRYPTHEX("0x00F0271E0008201EC0035FD6") // Patch vizual
    }
  ];

  // 4. SPEED HACK (Slider)
  [switches addSliderSwitch:NSSENCRYPT("Custom Move Speed")
    description:NSSENCRYPT("Setează viteza de mișcare")
    minimumValue:0
    maximumValue:10
    sliderColor:UIColorFromHex(0xBD0000)
  ];

}

void setupMenu() {
  // Setăm framework-ul la UnityFramework pentru ca offsets să fie valide
  [menu setFrameworkName:"UnityFramework"];

  menu = [[Menu alloc]
    initWithTitle:NSSENCRYPT("ONESTATE RP - MOD MENU")
    titleColor:[UIColor whiteColor]
    titleFont:NSSENCRYPT("Copperplate-Bold")
    credits:NSSENCRYPT("Mod realizat de @AlexUYonut")
    headerColor:UIColorFromHex(0xBD0000)
    switchOffColor:[UIColor darkGrayColor]
    switchOnColor:UIColorFromHex(0x00ADF2)
    switchTitleFont:NSSENCRYPT("Copperplate-Bold")
    switchTitleColor:[UIColor whiteColor]
    infoButtonColor:UIColorFromHex(0xBD0000)
    maxVisibleSwitches:4
    menuWidth:250
  ];

  setup(); // Încarcă switch-urile de mai sus
}

static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  timer(5) {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert addButton:NSSENCRYPT("Înțeles!") actionBlock: ^(void) {
        timer(2) {
            setupMenu();
        };
    }];
    
    alert.shouldDismissOnTapOutside = NO;
    alert.customViewColor = [UIColor purpleColor];
    alert.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;
    
    [alert showSuccess:nil 
             subTitle:NSSENCRYPT("ONESTATE RP\n\nMod Menu a fost încărcat cu succes!") 
       closeButtonTitle:nil 
               duration:9999999.0f];
  };
}

%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)@"UIApplicationDidFinishLaunchingNotification", NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}
