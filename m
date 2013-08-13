MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20130811192713.GT5918@redhat.com>
References: <20130809204355.GA10864@redhat.com>
	<CAMuHMdX-ouj_9N1Kd6AGf_rziQ-ddZhzLaaijOvmxwxEjBoggg@mail.gmail.com>
	<20130811192713.GT5918@redhat.com>
Date: Tue, 13 Aug 2013 13:16:14 +0200
Message-ID: <CAMuHMdV1w8FDREXpqXzp6GRugdD5YofsTRAZsycuTyEbqDVtsg@mail.gmail.com>
Subject: Re: [uml-devel] Using UML in libguestfs
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Aug 11, 2013 at 9:27 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> On Sun, Aug 11, 2013 at 09:05:08PM +0200, Geert Uytterhoeven wrote:
>> On Fri, Aug 9, 2013 at 10:43 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
>> > * UML is pretty fast!  It's certainly faster (by a factor of > 5) than
>> > spinning up a lightweight KVM VM.
>
>> This is interesting. Typically people say you have to use KVM or XEN
>> for good virtualization performance. But for that you need
>> sufficient privileges.
>
> I think this is true of Xen, but to be fair to KVM it doesn't require
> special privileges, with one exception.  If you want KVM to use a tunX
> network interface then you have to start it as root (or use a setuid
> helper).  I think this is probably true of UML too although I've not

There you name it...

> explored UML's networking yet.  Basically it's a restriction in Linux
> itself.
>
>> With UML, all you need is to be able to compile and run your own
>> executables.

With UML, I can use slirp-fullbolt.

So if I want to run e.g. wireshark on the development machine at work (no root
for me), I just launch a UML with a Debian root fs that has wireshark and
run my app.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

