Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC08CD2E033
	for <linux-um@archiver.kernel.org>; Wed, 23 Oct 2024 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=61fNhnpcME2yV0iZnWOMXqgbr8vsfLVgQ9aY1BUWuWg=; b=YxQi598rshFFegqAANX0IbOSrN
	Ye2ZyCPfmEy6BZ9EiqYLsan3AZADLCchcXLfm21KMzZ7QBVSKEJoKNhTJsCfCl61H7BikiR76fd2D
	q+JQgSXJWZX4XLp3NtEDpRfImGWs0zuEnAMLD8w63eUb6EoP0bUoBQlr1S+ThqfaGXajlqxSuQDpN
	sKtIYXzOrtbt2wi62I1bwvvlhv2X6GBtoB8xR/HC82jdPoQw/3pbsKRSUv2LtPDL8wZxKM2FZXIES
	D5XlHbi7HNJUB7tyV66lvtDAwjfw7fqyQbdVE5WYnJW/1+a68tMEfeSYcSl8naD2TIrHlFOlch6jK
	L++AMTXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Xlb-0000000DoxD-3Qhy;
	Wed, 23 Oct 2024 09:34:59 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3XOp-0000000DjFz-0LO0
	for linux-um@lists.infradead.org;
	Wed, 23 Oct 2024 09:11:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=61fNhnpcME2yV0iZnWOMXqgbr8vsfLVgQ9aY1BUWuWg=;
	t=1729674686; x=1730884286; b=uYHmwD71CqTOG4Y1qpSwrj1il/xWJDdxpfIJRsIvr4WRIRQ
	NgzadnlG921pKmcrtznN5TozYftDkubWwI1n7tt2J0gZJNGOEn6aqTtJr7/xhNPA0pvSHqLuOSr9j
	v2Y3x8iAAQwVYhra5rCCE1jWbxmw5h1vDLXDV0G4lxzyTpEPInLdgRe+zXbkoWEF8gKPDuxO8ld5Y
	9Xn6AmJflZPXXdnGwjomI3Qma6dudV3ghjr6MVvrphIcuqUfP2ApdFjts2uuKFbxXbPt4YOn+Hbkq
	XBj+FG8yG12jP6eD0fosTZhWCLe6F8w+VzpQ6xWYE26CWhJZW3S5dtMxuxTVBARw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3XOk-00000002a3b-1uy1;
	Wed, 23 Oct 2024 11:11:22 +0200
Message-ID: <c5008396fcce3713b1abec65d689e3c52eddce59.camel@sipsolutions.net>
Subject: Re: [PATCH v3] um: switch to regset API and depend on XSTATE
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Wed, 23 Oct 2024 11:11:21 +0200
In-Reply-To: <20241023082942.4054577-1-benjamin@sipsolutions.net>
References: <20241023082942.4054577-1-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_021127_332594_41A52A8B 
X-CRM114-Status: GOOD (  15.23  )
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

On Wed, 2024-10-23 at 10:29 +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
>=20
> The PTRACE_GETREGSET API has now existed since Linux 2.6.33. The XSAVE
> CPU feature should also be sufficiently common to be able to rely on it.
>=20
> With this, define our internal FP state to be the hosts XSAVE data. Add
> discovery for the hosts XSAVE size and place the FP registers at the end
> of task_struct so that we can adjust the size at runtime.
>=20
> Next we can implement the regset API on top and update the signal
> handling as well as ptrace APIs to use them. Also switch coredump
> creation to use the regset API and finally set HAVE_ARCH_TRACEHOOK.
>=20
> This considerably improves the signal frames. Previously they might not
> have contained all the registers (i386) and also did not have the
> sizes and magic values set to the correct values to permit userspace to
> decode the frame.
>=20
> As a side effect, this will permit UML to run on hosts with newer CPU
> extensions (such as AMX) that need even more register state.
>=20
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>=20
> ---
>=20
> v3:
> * Fix FP register initialization, thanks to Johannes Berg
>=20

Still causes problems with new userspace processes being killed due to:

userspace - ptrace set fp regs failed, errno =3D 22

(at least on 32-bit, hadn't seen it on 64-bit yet)

I dumped the FP state that couldn't be set in case that helps anything:

fp state:00000000: 7f 02 20 40 00 00 00 00 12 a0 06 08 00 00 00 00
fp state:00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000001a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000001b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000001c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000001d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000001e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000001f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000210: 00 00 00 00 00 00 00 00 80 49 8b 47 00 10 00 00
fp state:00000220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000002a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000002b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000002c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000002d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000002e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000002f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000003a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000003b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000003c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000003d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000003e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000003f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000004a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000004b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000004c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000004d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000004e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000004f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000005a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000005b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000005c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000005d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000005e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000005f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000006a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000006b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000006c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000006d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000006e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000006f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000007a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000007b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000007c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000007d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000007e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000007f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000810: 00 00 00 00 00 00 00 00 00 bc 32 0a 00 00 00 00
fp state:00000820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000008a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000008b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000008c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000008d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000008e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000008f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000009a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000009b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000009c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000009d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000009e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:000009f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fp state:00000a80: 00 00 00 00 00 00 00 00


johannes

