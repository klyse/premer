import { useState } from "react";

export default function Main() {
  const [email, setEmail] = useState(null);

  return (
    <section className="body-font">
      <div className="max-w-7xl mx-auto flex px-5 py-24 md:flex-row flex-col items-center">
        <div className="lg:flex-grow md:w-1/2 md:ml-24 pt-6 flex flex-col md:items-start md:text-left mb-40 items-center text-center">
          <h1 className="mb-5 sm:text-6xl text-5xl items-center Avenir xl:w-2/2 text-turquoise">
            Vibration based timer for your next Presentation
          </h1>
          <p className="mb-4 xl:w-3/4 text-lg">
            PREMER is a free Apple Watch app that helps you keep track of time
            during a talk.
          </p>
          <div className="flex justify-center">
            <a
              className="inline-flex items-center px-5 py-3 mt-2 font-medium transition duration-500 ease-in-out transform bg-transparent border rounded-lg bg-gray-900"
              href="#more"
            >
              <span className="justify-center">Find out more</span>
            </a>
          </div>
        </div>
        <div className="xl:mr-44 sm:mr-0 sm:mb-28 mb-0 lg:mb-0 mr-48 md:pl-10">
          <img
            className="w-80 md:ml-1 ml-24"
            alt="watch"
            src="/images/watch.png"
          ></img>
        </div>
      </div>
      <div id="more" className="max-w-7xl pt-20 mx-auto text-center">
        <h1 className="mb-8 text-6xl Avenir font-semibold">
          Never run out of time again.
        </h1>
        <h1 className="mb-8 md:w-3/4 text-lg mx-auto px-4 text-center">
          Get four vibration indications on your Apple Watch while your
          presentation. You'll get a vibration after every quarter of your talk.
          So you always know how much time is left.
        </h1>
        <div className="container flex flex-col items-center justify-center mx-auto w-3/4 aspect-video">
          <iframe
            src="https://player.vimeo.com/video/824473133?h=2eb22d031e&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479"
            width="100%"
            height="100%"
            allow="autoplay; fullscreen; picture-in-picture"
            title="PREMER - Vibration based Presentation Timer"
          ></iframe>
        </div>
      </div>
      <section className="relative">
        <div className="mt-12">
          <h1 className="mb-5 text-6xl Avenir font-semibold text-center">
            Download for Free!
          </h1>

          <a
            href="https://apps.apple.com/us/app/premer/id6448866927"
            target="_blank"
          >
            <img src="/images/appstore.svg" className="m-auto w-44" />
          </a>
        </div>
      </section>
      <section className="relative">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 text-center">
          <div className="py-24 md:py-36">
            <form action="https://formspree.io/f/mqkonngo" method="POST">
              <h1 className="mb-5 text-6xl Avenir font-semibold">
                Subscribe to our newsletter
              </h1>
              <h1 className="mb-9 text-2xl font-semibold">
                Enter your email address and get our newsletters straight away.
              </h1>
              <input
                placeholder="jack@example.com"
                onChange={(e) => setEmail(e.target.value)}
                name="email"
                type="email"
                autoComplete="email"
                className="border border-gray-600 w-72 pr-2 pl-2 py-3 mt-2 rounded-md font-semibold hover:border-gray-900 text-black"
              ></input>{" "}
              <button
                disabled={!email}
                type="submit"
                className="inline-flex items-center py-3 mt-2 xl:ml-2 w-72 font-medium transition duration-500 ease-in-out transform bg-transparent border rounded-lg bg-gray-900"
                href="/"
              >
                <span className="mx-auto">Subscribe</span>
              </button>
              <p className="text-sm pt-4">
                By Subscribing you agree to the{" "}
                <a
                  className="hover:underline text-blue-600"
                  href="/terms-of-service"
                >
                  Terms of Servie
                </a>{" "}
                and to receive email from us ;)
              </p>
            </form>
          </div>
        </div>
      </section>
    </section>
  );
}
