#include <alcommon/albroker.h>
#include <alproxies/almotionproxy.h>
#include <alproxies/altexttospeechproxy.h>
#include <alproxies/alledsproxy.h>
#include <iostream>

using namespace std;

int main(int argc, char* argv[]) {

    if (argc < 2) {
        cerr << "Usage: " << argv[0] << " <NAO_IP>" << endl;
        return 1;
    }

    const string NAO_IP = argv[1];
    const int NAO_PORT = 9559;

    try {
        boost::shared_ptr<AL::ALBroker> broker;
        broker = AL::ALBroker::createBroker(
            "NaoBroker",
            "",
            0,
            NAO_IP,
            NAO_PORT
        );

        AL::ALTextToSpeechProxy tts(NAO_IP, NAO_PORT);
        AL::ALMotionProxy motion(NAO_IP, NAO_PORT);

		motion.wakeUp();

        tts.say("Olá UnBeatables");

		motion.rest();
    }
    catch (const exception& e) {
        cerr << "Erro: " << e.what() << endl;
        return -1;
    }
    return 0;
}
