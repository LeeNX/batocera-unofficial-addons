# 🎮 Java ME Game Emulator for Batocera

Hello! 👋
Welcome to the project to install the Java ME game emulator, Freej2me, on your Batocera.

This project includes all the necessary resources to ensure full functionality on your Batocera.

This project has been successfully tested on Batocera v.38, v.39, v.40, v.41 and v.42

## 🚀 Installation Instructions

To start the installation, copy the command below, paste it into your terminal, and press Enter to begin the installation:

```sh
curl -L bit.ly/drl-j2me | bash
```

Remember that after installation is complete, this installer will include two versions of Freej2me:
1. **Freej2me**: The standard emulator.
2. **Freej2me with Retroarch emulation**: Through the libretro core of Retroarch.

## 🔄 Switching Between Emulations

When browsing your front-end, you will find a file called `-Update_j2me` inside the Ports collection. Simply launch this script to switch between the standard Freej2me emulation and the Retroarch libretro emulation.

This feature was implemented to ensure a smooth user experience while running J2ME emulations.

## 🎮 Gamepad Support

The standard Freej2me emulation already includes a gamepad recognition feature. However, Retroarch emulation is still in the testing phase, but you can experiment and customize it.

---
# Key Mapping and Input Shortcuts for the Freej2me Emulator Installed on Batocera

## The standard Freej2me emulation already includes a gamepad recognition feature. However, Retroarch emulation is still in the testing phase, but you can experiment and customize it.

![image](https://github.com/DRLEdition19/batocera-unofficial-addons.add/raw/refs/heads/main/Freej2me/extra/joytick.jpg)

# The following control settings correspond to the keyboard buttons illustrated above.
---
## Common Keyboard Shortcuts

|**🎮Gamepad / Joystick🕹️**|    **Keys**     | **Functions as** |
| :--------------: | :------------: | :--------------: |
| **Start**        |      Esc       | Freej2me Options Menu |
| **🔺 / X** or **L1**  |       Q        |   Options Key / Select    |
| **⭕ / A** or **R1**  |       W        |     Back Key     |
| **L2**           |       E        |        *         |
| **R2**           |       R        |        #         |
| **D-PAD** or **🕹L-ANALOG**      |   Number line   |  Numeric keyboard  |
| **D-PAD** or **🕹L-ANALOG**      | Numeric keyboard 7,8,9 |      1,2,3       |
| **D-PAD** or **🕹L-ANALOG**      | Numeric keyboard 4,5,6 |      4,5,6       |
| **D-PAD** or **🕹L-ANALOG**      | Numeric keyboard 1,2,3 |      7,8,9       |

## Standard Keyboard Shortcuts

All **common key combinations** below:

|**🎮Gamepad / Joystick🕹️**|    **Keys**     | **Functions as** |
| :--------------: | :---------: | :--------------: |
| **![image](https://github.com/DRLEdition19/J2me-Batocera/blob/main/Freej2me/extra/Acima.png?raw=true)D-PAD UP** or **🕹L-ANALOG UP**       |  Up Arrow      | 2 |
| **![image](https://github.com/DRLEdition19/J2me-Batocera/blob/main/Freej2me/extra/Abaixo.png?raw=true)D-PAD DOWN** or **🕹L-ANALOG DOWN**   |  Down Arrow     | 8 |
| **![image](https://github.com/DRLEdition19/J2me-Batocera/blob/main/Freej2me/extra/Esquerda.png?raw=true)D-PAD LEFT** or **🕹L-ANALOG LEFT**   |  Left Arrow  | 4 |
| **![image](https://github.com/DRLEdition19/J2me-Batocera/blob/main/Freej2me/extra/Direita.png?raw=true)D-PAD RIGHT** or **🕹L-ANALOG RIGHT** |  Right Arrow   | 6 |
| **🕹R-ANALOG LEFT**    | *TOP LEFT DIAGONAL* | 1 |
| **🕹R-ANALOG UP**      | *LOWER LEFT DIAGONAL* | 3 |
| **🕹R-ANALOG DOWN**    | *LOWER RIGHT DIAGONAL* | 7 |
| **🕹R-ANALOG RIGHT**   | *TOP RIGHT DIAGONAL* | 9 |
| **⏹️ / Y**             |       A         | ??? |
| **✖️ / B**             |       Enter         | 5 |

## Nokia Keyboard Shortcuts

All **common shortcut keys** below:

|**🎮Gamepad / Joystick🕹️**|    **Keys**     | **Functions as** |
| :--------------: | :------------: | :--------------------: |
| **![image](https://github.com/DRLEdition19/J2me-Batocera/blob/main/Freej2me/extra/Acima.png?raw=true)D-PAD UP** or **🕹L-ANALOG UP**       | Up Arrow     |            Up            |
| **![image](https://github.com/DRLEdition19/J2me-Batocera/blob/main/Freej2me/extra/Abaixo.png?raw=true)D-PAD DOWN** or **🕹L-ANALOG DOWN**   | Down Arrow    |           Down            |
| **![image](https://github.com/DRLEdition19/J2me-Batocera/blob/main/Freej2me/extra/Esquerda.png?raw=true)D-PAD LEFT** or **🕹L-ANALOG LEFT**   | Left Arrow |          Left          |
| **![image](https://github.com/DRLEdition19/J2me-Batocera/blob/main/Freej2me/extra/Direita.png?raw=true)D-PAD RIGHT** or **🕹L-ANALOG RIGHT** | Right Arrow  |          Right           |
| **⏹️ / Y**             |       A         | ??? |
| **✖️ / B**                                 |      Enter         | Action Key (**OK** button) |

---

Enjoy the emulator and have fun with your favorite Java ME games on Batocera! 😃

## Acknowledgements

Thanks to the developer **hex007**, for developing and making **Freej2me** available. The development of this project would be nothing without the existence of **Freej2me**.

You can access the official page by clicking on this link:
https://github.com/hex007/freej2me
