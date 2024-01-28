import Head from "next/head";
import Header from "../components/Header";
import Main from "../components/Main";
import Footer from "../components/Footer";
import { NextSeo } from "next-seo";
import Banner from "../components/Banner";

export default function Home() {
  return (
    <div>
      <NextSeo
        title="Home: PREMER"
        description="Welcome to PREMER homepage."
        canonical="https://premer.klyse.eu/"
        openGraph={{
          url: "https://premer.klyse.eu/",
        }}
      />
      <Head>
        <title>PREMER | Home</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Header />
      <Main />
      <Footer />
    </div>
  );
}
