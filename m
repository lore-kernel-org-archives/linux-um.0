Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC19C3DA6E
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HEA3aPpB6WL9wYUF2ijzbIH3oF2JYOlB67zMjX4z7HQ=; b=HfhUymEC4kwFUAcixUmxBFBvuw
	7AIrd7ecdVfrKaEl+H32iAWTYfVYVD2R7Q7x9f45O2t1ExbZ6+Io3txJy5rp3+2fwjqpLQ/OcOQoq
	hsejZbc63tyif7015yDYIk4kteAx4TkE8WYc3ZRJdVAssnPDiEmUdangEVvxfhsR16sQtQhFKthDt
	iTe00Hvz8GCSMccVNGNgDrjlFjt6vpEm7+Wjjgz28buZM8ZYtZN8CWvzD+OmeydKhacLqM0Lju9tw
	fVQzj2tAkP5YIBfPbe0bRn5cO8YvOTcjnJ83vg3Ha1YvypJaCdcTRkCykkrvaJq84RKZx6HVIClui
	Z2HhYQrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLguG-00GSCw-29;
	Fri, 05 Jan 2024 09:54:24 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLguD-00GSBl-0O
	for linux-um@lists.infradead.org;
	Fri, 05 Jan 2024 09:54:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HEA3aPpB6WL9wYUF2ijzbIH3oF2JYOlB67zMjX4z7HQ=;
	t=1704448459; x=1705658059; b=n/i7Xc+JyLWTLHHL8LKu2Lw2gigJJNtFI8s6M2k05zpuneX
	37UHP0E4yKAQommgato6jweJI6rrHqj7jM5hK6eWV7JW0QBULoyql0dXF8XvdXvcFMDuPDa2UbpSL
	HyJ4HJUtzyoux2elCJmLohHFC9WIWb313nClPQlDGYpnNudQ8xJQHw7bnuFi1u/+e2y6IRQcUfc6c
	fm2shxeFC3IEScIb/PfLjvkOo3zouewsl1uYufdMmeYDRWzTRjJj/FN02O8feM0XXBmq0YkxYJKBE
	CvRTJ89Oi2bG1ol9PBIQiL4EBWTtcdfUE2ccNFVWz3k6RG30Rf7LthE/a8wenuzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rLgu9-00000005yMx-2Zps;
	Fri, 05 Jan 2024 10:54:17 +0100
Message-ID: <9ec2eafe0ea44e3bce1e5fa96c4a9488c3d43a8c.camel@sipsolutions.net>
Subject: Re: [PATCH v3 09/11] um: Rely on PTRACE_SETREGSET to set FS/GS base
 registers
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: linux-um@lists.infradead.org
Date: Fri, 05 Jan 2024 10:54:15 +0100
In-Reply-To: <CAFLxGvx6zVDy8pjacb8Dq9d884gTjpnPUapJ61GZAMy_39wGWg@mail.gmail.com>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
	 <20231110110348.1815612-10-benjamin@sipsolutions.net>
	 <CAFLxGvx6zVDy8pjacb8Dq9d884gTjpnPUapJ61GZAMy_39wGWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_015421_154993_A9D67D0E 
X-CRM114-Status: GOOD (  25.09  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, 2024-01-05 at 00:05 +0100, Richard Weinberger wrote:
> On Fri, Nov 10, 2023 at 12:03=E2=80=AFPM <benjamin@sipsolutions.net> wrot=
e:
> >=20
> > From: Benjamin Berg <benjamin@sipsolutions.net>
> >=20
> > These registers are saved/restored together with the other general
> > registers using ptrace. In arch_set_tls we then just need to set
> > the
> > register and it will be synced back normally.
> >=20
> > Most of this logic was introduced in commit f355559cf7845 ("[PATCH]
> > uml:
> > x86_64 thread fixes"). However, at least today we can rely on
> > ptrace to
>=20
> Do you know since when exactly? I don't want to break UML in subtle ways
> on old kernels.

To be honest, I don't remember, and I doubt I really understood what I
was doing.

Anyway, I now found this commit now, which is contained in v2.6.25:

commit df5d438e33d7fc914ba9b6e0d6b019a8966c5fcc
Author: Roland McGrath <roland@redhat.com>
Date:   Wed Jan 30 13:30:45 2008 +0100

    x86: ptrace fs/gs_base
   =20
    The fs_base and gs_base fields are available in user_regs_struct.
    But reading these via ptrace (PTRACE_GETREGS or PTRACE_PEEKUSR) does
    not give a reliably useful value.  The thread_struct fields are 0
    when do_arch_prctl decided to use a GDT slot instead of MSR_FS_BASE,
    which it does for a value under 1<<32.
   =20
    This changes ptrace access to fs_base and gs_base to work like
    PTRACE_ARCH_PRCTL does.  That is, it reads the base address that
    user-mode memory access using the fs/gs instruction prefixes will
    use, regardless of how it's being implemented in the kernel.  The
    MSR vs GDT is an implementation detail that is pretty much hidden
    from userland in the actual using, and there is no reason that
    ptrace should give the internal implementation picture rather than
    the user-mode semantic picture.  In the case of setting the value,
    this can implicitly change the fsindex/gsindex value (also
    separately in user_regs_struct), which is what happens when the
    thread calls arch_prctl itself.  In a PTRACE_SETREGS, the fs_base
    change will come after the fsindex change due to the order of the
    struct, and so a change the debugger made to fs_base will have the
    effect intended, another part of the user_regs_struct will now
    differ when read back from what the debugger wrote.
   =20
    This makes PTRACE_ARCH_PRCTL obsolete.  We could consider declaring
    it deprecated and removing it one day, though there is no hurry.
    For the foreseeable future, debuggers have to assume an old kernel
    that does not report reliable fs_base/gs_base values in user_regs_struc=
t
    and stick to PTRACE_ARCH_PRCTL anyway.

I think the last paragraph is quite straight forward in saying that we
do not need anything special anymore. Note that the original commit
adding the code pre-dates this commit by about a year, i.e.:

commit f355559cf78455ed6be103b020e4b800230c64eb
Author: Jeff Dike <jdike@addtoit.com>
Date:   Sat Feb 10 01:44:29 2007 -0800

    [PATCH] uml: x86_64 thread fixes
   =20
    x86_64 needs some TLS fixes.  What was missing was remembering the chil=
d
    thread id during clone and stuffing it into the child during each conte=
xt
    switch.
   =20
    The %fs value is stored separately in the thread structure since the ho=
st
    controls what effect it has on the actual register file.  The host also=
 needs
    to store it in its own thread struct, so we need the value kept outside=
 the
    register file.
   =20
    arch_prctl_skas was fixed to call PTRACE_ARCH_PRCTL appropriately.  The=
re is
    some saving and restoring of registers in the ARCH_SET_* cases so that =
the
    correct set of registers are changed on the host and restored to the pr=
ocess
    when it runs again.

There was some shuffling around in the ptrace code at some point,
eventually switching from doing an arch_prctl call to setting things
more directly. But I don't think that matters to us.

Benjamin

