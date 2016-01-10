Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1452438425.7773.21.camel@perches.com>
Subject: Re: [PATCH v2 1/3] checkpatch.pl: add missing memory barriers
From: Joe Perches <joe@perches.com>
Date: Sun, 10 Jan 2016 07:07:05 -0800
In-Reply-To: <1452427000-4520-2-git-send-email-mst@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
	 <1452427000-4520-2-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, 2016-01-10 at 13:56 +0200, Michael S. Tsirkin wrote:
> SMP-only barriers were missing in checkpatch.pl
>=20
> Refactor code slightly to make adding more variants easier.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5116,7 +5116,25 @@ sub process {
> =EF=BF=BD			}
> =EF=BF=BD		}
> =EF=BF=BD# check for memory barriers without a comment.
> -		if ($line =3D~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_=
wmb|smp_read_barrier_depends)\(/) {
> +
> +		my $barriers =3D qr{
> +			mb|
> +			rmb|
> +			wmb|
> +			read_barrier_depends
> +		}x;
> +		my $smp_barriers =3D qr{
> +			store_release|
> +			load_acquire|
> +			store_mb|
> +			($barriers)
> +		}x;

If I use a variable called $smp_barriers, I'd expect
it to actually be the smp_barriers, not to have to
prefix it with smp_ before using it.

		my $smp_barriers =3D qr{
			smp_store_release|
			smp_load_acquire|
			smp_store_mb|
			smp_read_barrier_depends
		}x;

or

		my $smp_barriers =3D qr{
			smp_(?:store_release|load_acquire|store_mb|read_barrier_depends)
		}x;

=EF=BF=BD
> +		my $all_barriers =3D qr{
> +			$barriers|
> +			smp_($smp_barriers)
> +		}x;

And this shouldn't have a capture group.

		my $all_barriers =3D qr{
			$barriers|
			$smp_barriers
		}x;	=09
> +
> +		if ($line =3D~ /\b($all_barriers)\s*\(/) {

This doesn't need the capture group either (?:all_barriers)

> =EF=BF=BD			if (!ctx_has_comment($first_line, $linenr))
> {
> =EF=BF=BD				WARN("MEMORY_BARRIER",
> =EF=BF=BD				=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD"memory barrier=
 without
> comment\n" . $herecurr);


