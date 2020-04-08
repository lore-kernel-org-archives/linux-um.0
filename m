Return-Path: <mlureau@redhat.com>
MIME-Version: 1.0
References: <7c37a3f7310c0be2202ada464e31c2d4d424c502.camel@researchut.com>
 <32d50bed-cfdb-288a-181c-e186143c8169@kot-begemot.co.uk> <44b7a3a49731dfabe9cdfbeb281ad9470e71b625.camel@researchut.com>
 <c6774e9e-7811-cbbb-eea5-83e5045b59e9@kot-begemot.co.uk> <41e0199cf2ad126bca3047d18e14493ab903bbe6.camel@researchut.com>
 <f64a6f99-8e20-9825-75eb-358054935807@kot-begemot.co.uk> <ac5e36bea0200b8613849ef529d84de54b3afe70.camel@researchut.com>
 <CAMuHMdWTOg9MR73qUEFtDB4fsV0Q1Li4+ZH+cQCfzxwXw2jBtg@mail.gmail.com> <aeefc761-30ea-e753-8d58-eb180e372d24@kot-begemot.co.uk>
In-Reply-To: <aeefc761-30ea-e753-8d58-eb180e372d24@kot-begemot.co.uk>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 8 Apr 2020 15:20:36 +0200
Message-ID: <CAMxuvazQa0fUPUvyEiV0oace1=ZHhkqw4kNGE1i7rAWBwWwbtA@mail.gmail.com>
Subject: Re: Documentation for UML Vector network
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, rrs@researchut.com, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

Hi Anton

On Wed, Apr 8, 2020 at 2:59 PM Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
>
>
> On 08/04/2020 13:40, Geert Uytterhoeven wrote:
> > Hi Ritesh,
> >
> > On Wed, Apr 8, 2020 at 1:05 PM Ritesh Raj Sarraf <rrs@researchut.com> w=
rote:
> >> On Tue, 2020-04-07 at 17:36 +0100, Anton Ivanov wrote:
> >>> I am happy to handle proposed changes as pull requests.
> >> Thank you for following up on this one. There's one item I felt could
> >> be expanded. I created a PR for it on the Github repo.
> >>
> >> I felt this was worth documenting because UML's prime selling point is
> >> that it can run as a normal user.
> >>
> >> https://github.com/kot-begemot-uk/uml-howto-v2/pull/1
> >> Netowrk configuration privilege
> > Network
>
> Thanks.
>
> >
> > And then there's slirp...
>
> I know... it is something I need to figure out on how to do with the vect=
or framework.
>
> The patch proposed yesterday to add a generic fd transport goes half-way =
to fix that, all it needs is sorting out the helper to do the actual slirp =
processing.
>

Yes, I started writing a spec for slirp helpers:
https://gitlab.freedesktop.org/slirp/libslirp/-/wikis/Slirp-Helper

With libslirp-helper (from
https://gitlab.freedesktop.org/slirp/libslirp-rs) or slirpnetstack
(from https://github.com/majek/slirpnetstack) you can simply specify
--fd=3D with a socketpair connected to the vec driver.

I also started a discussion for easier/better user networking for VM &
containers with NM:
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/issues/382.

Your input is welcome!


> >
> > Gr{oetje,eeting}s,
> >
> >                          Geert
> >
> --
> Anton R. Ivanov
> https://www.kot-begemot.co.uk/
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>


