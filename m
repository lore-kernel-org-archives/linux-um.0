MIME-Version: 1.0
Date: Fri, 29 Nov 2019 16:05:27 +0100
References: <3820d68b-1d97-8f41-d55d-237d1695458c@cambridgegreys.com>
In-Reply-To: <3820d68b-1d97-8f41-d55d-237d1695458c@cambridgegreys.com>
Message-ID: <CAMuHMdWuiGC4ay=f6M2H=-PLiffavnFSu8CPXE26euAi6aoY0w@mail.gmail.com>
Subject: Re: 64 bit time regression in recvmmsg()
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um <linux-um@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-um.lists.infradead.org>

CC Arnd

On Fri, Nov 29, 2019 at 3:34 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
> Unfortunately, it looks like the recent year 2038 have broken
> compatibility for one particular syscall interface we use - recvmmsg.
>
> The host now occasionally returns -22 (EINVAL) and the only way I see
> for this to happen looking at the source is if when it gets something
> bogus as a timeout.
>
> I think I have eliminated all other possible sources for this error.
>
> The picture can be observed when using a 64 bit host 5.2 kernel on a
> Debian 64 bit buster userspace (glibc compiled vs 4.19 headers).
>
> The code as it is written at present retries and by sheer luck and
> perseverance it manages to work, but this needs to be fixed.

