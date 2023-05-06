import Head from "next/head";
import Header from "../components/Header";
import Main from "../components/Main";
import Footer from "../components/Footer";
import { NextSeo } from "next-seo";

export default function Home() {
  return (
    <div>
      <NextSeo
        title="Home: premer"
        description="Welcome to premer homepage."
        canonical="https://premer.klyse.eu/"
        openGraph={{
          url: "https://premer.klyse.eu/",
        }}
      />
      <Head>
        <title>premer</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Header />
      <Main />
      <Footer />
    </div>
  );
}
