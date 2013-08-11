MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20130809204355.GA10864@redhat.com>
References: <20130809204355.GA10864@redhat.com>
Date: Sun, 11 Aug 2013 21:05:08 +0200
Message-ID: <CAMuHMdX-ouj_9N1Kd6AGf_rziQ-ddZhzLaaijOvmxwxEjBoggg@mail.gmail.com>
Subject: Re: [uml-devel] Using UML in libguestfs
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Aug 9, 2013 at 10:43 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> * UML is pretty fast!  It's certainly faster (by a factor of > 5) than
> spinning up a lightweight KVM VM.

This is interesting. Typically people say you have to use KVM or XEN for
good virtualization performance. But for that you need sufficient privileges.
With UML, all you need is to be able to compile and run your own
executables.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

