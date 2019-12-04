Return-Path: <arnd@arndb.de>
MIME-Version: 1.0
References: <3820d68b-1d97-8f41-d55d-237d1695458c@cambridgegreys.com>
 <CAMuHMdWuiGC4ay=f6M2H=-PLiffavnFSu8CPXE26euAi6aoY0w@mail.gmail.com>
 <CAK8P3a1mrFgRyh5Fgv-d8Szd2pq0T6Ac7wL3ogeYcf-Uyrg4ZQ@mail.gmail.com> <a5b9709d-b93b-46e1-ab18-a94ab921ccf7@cambridgegreys.com>
In-Reply-To: <a5b9709d-b93b-46e1-ab18-a94ab921ccf7@cambridgegreys.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Dec 2019 22:08:43 +0100
Message-ID: <CAK8P3a2A13pfvRRvpamx1woUz0CZTR3gvt_P1-ERqH+QtRATig@mail.gmail.com>
Subject: Re: 64 bit time regression in recvmmsg()
Content-Type: text/plain; charset="UTF-8"
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Fri, Nov 29, 2019 at 5:34 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
>
> On 29/11/2019 15:17, Arnd Bergmann wrote:
> > On Fri, Nov 29, 2019 at 4:05 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> On Fri, Nov 29, 2019 at 3:34 PM Anton Ivanov
> >> <anton.ivanov@cambridgegreys.com> wrote:
> >>> Unfortunately, it looks like the recent year 2038 have broken
> >>> compatibility for one particular syscall interface we use - recvmmsg.
> >>>
> >>> The host now occasionally returns -22 (EINVAL) and the only way I see
> >>> for this to happen looking at the source is if when it gets something
> >>> bogus as a timeout.
> >>>
> >>> I think I have eliminated all other possible sources for this error.
> >>>
> >>> The picture can be observed when using a 64 bit host 5.2 kernel on a
> >>> Debian 64 bit buster userspace (glibc compiled vs 4.19 headers).
> >>>
> >>> The code as it is written at present retries and by sheer luck and
> >>> perseverance it manages to work, but this needs to be fixed.
> >
> > I only see a single call to recvmmsg() in arch/um, in uml_vector_recvmmsg(),
> > and this passes a NULL timeout pointer, is this the one that broke or
> > should I be looking at something else?
> >
> > Do I understand you right that the regression is on a pure 64-bit system?
>
> Yes.
>
> 64 bit host, Debian Buster with the stock 4.19 replaced by a 5.2.17
> kernel upgrade, 5.2 and 5.3 64 bit UML also running Debian Buster inside.
>
> It sporadically produces -EINVAL (-22) from the recvmmsg.
>
> I went through the allocation and deallocation of the actual mmsg
> several times to ensure it is not that.
>
> IMHO it is the timespec conversion somewhere, but I cannot pinpoint the
> actual cause.
>

I've looked at the changes again as well now without finding anything
suspicious. The only commit of mine that significantly changes recvmmsg
is e11d4284e2f4 ("y2038: socket: Add compat_sys_recvmmsg_time64").
I tried reverting it on top of  5.2.17, but that causes a lot of conflicts.

The best suggestion I still have would be to check out the kernel before
and after this commit, to see if it is the root cause. This one was part
of the linux-5.0 merge window, so right in the middle of the range
you have identified.

     Arnd

