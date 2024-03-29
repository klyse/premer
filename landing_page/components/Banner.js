"use client";
import { useState } from "react";

export default function Banner() {
  const [bannerOpen, setBannerOpen] = useState(true);

  if (!bannerOpen) {
    return <></>;
  }
  return (
    <div
      id="sticky-banner"
      tabindex="-1"
      class="z-50 flex justify-between w-full p-4  bg-orange-400"
    >
      <div class="flex items-center mx-auto">
        <p class="flex items-center text-sm font-normal text-white">
          <span class="inline-flex p-1 me-3 bg-gray-200 rounded-full w-6 h-6 items-center justify-center flex-shrink-0">
            <svg
              class="w-3 h-3 text-gray-500"
              aria-hidden="true"
              xmlns="http://www.w3.org/2000/svg"
              fill="currentColor"
              viewBox="0 0 18 19"
            >
              <path d="M15 1.943v12.114a1 1 0 0 1-1.581.814L8 11V5l5.419-3.871A1 1 0 0 1 15 1.943ZM7 4H2a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2v5a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2V4ZM4 17v-5h1v5H4ZM16 5.183v5.634a2.984 2.984 0 0 0 0-5.634Z" />
            </svg>
            <span class="sr-only">Light bulb</span>
          </span>
          <span>
            Development has been discontinued due to the new behavior of the
            digital crown in watchOS 10.
          </span>
        </p>
      </div>
      <div class="flex items-center">
        <button
          data-dismiss-target="#sticky-banner"
          type="button"
          onClick={() => setBannerOpen(false)}
          class="flex-shrink-0 inline-flex justify-center w-7 h-7 items-center text-white hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5"
        >
          <svg
            class="w-3 h-3"
            aria-hidden="true"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 14 14"
          >
            <path
              stroke="currentColor"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"
            />
          </svg>
          <span class="sr-only">Close banner</span>
        </button>
      </div>
    </div>
  );
}
