Return-Path: <rjones@redhat.com>
Date: Sun, 11 Aug 2013 20:27:13 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130811192713.GT5918@redhat.com>
References: <20130809204355.GA10864@redhat.com>
 <CAMuHMdX-ouj_9N1Kd6AGf_rziQ-ddZhzLaaijOvmxwxEjBoggg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX-ouj_9N1Kd6AGf_rziQ-ddZhzLaaijOvmxwxEjBoggg@mail.gmail.com>
Subject: Re: [uml-devel] Using UML in libguestfs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Aug 11, 2013 at 09:05:08PM +0200, Geert Uytterhoeven wrote:
> On Fri, Aug 9, 2013 at 10:43 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> > * UML is pretty fast!  It's certainly faster (by a factor of > 5) than
> > spinning up a lightweight KVM VM.

> This is interesting. Typically people say you have to use KVM or XEN
> for good virtualization performance. But for that you need
> sufficient privileges.

I think this is true of Xen, but to be fair to KVM it doesn't require
special privileges, with one exception.  If you want KVM to use a tunX
network interface then you have to start it as root (or use a setuid
helper).  I think this is probably true of UML too although I've not
explored UML's networking yet.  Basically it's a restriction in Linux
itself.

> With UML, all you need is to be able to compile and run your own
> executables.

With libguestfs we specifically don't want people to use root, so UML
not requiring root was one reason why it's possible to write a
UML-based libguestfs backend.

I now have a UML backend for libguestfs working, with a significant
part of the testsuite passing too.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming blog: http://rwmj.wordpress.com
Fedora now supports 80 OCaml packages (the OPEN alternative to F#)

