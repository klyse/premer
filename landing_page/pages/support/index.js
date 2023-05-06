import Header from "../../components/Header";

export default function Home() {
  return (
    <>
      <Header />
      <div class="py-24 max-w-sm rounded overflow-hidden shadow-lg mx-auto">
        <div class="w-full max-w-xs self-center m-5">
          <h1 class="text-2xl pb-4">premer Support</h1>
          <span>
            If you need support, please feel free to reach out to us at{" "}
            <a
              class="text-blue-600 hover:underline"
              href="mailto:support@klyse.eu"
            >
              support@klyse.eu
            </a>
            . We are dedicated to providing you with the best possible
            assistance and will do our best to respond to your inquiry as soon
            as possible. We are looking forward to hearing from you!
          </span>
        </div>
      </div>
    </>
  );
}
