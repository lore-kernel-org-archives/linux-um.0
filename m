Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0ABCCF9E9
	for <linux-um@archiver.kernel.org>; Wed, 29 Oct 2025 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbDiRc1txlZTTk//UC1k3FW4pC0DVEyDhtcenS6QTzU=; b=RsBcSK+O16KIJ5UoPo43Qcf1S1
	oFcWHgIh8GCLpHRlCk7QOYOqhj3DelpbgkBDQa4BMoAVD0BjbtRCMoV3OnPB0m9L5WtUNIuNwNuKP
	1cLPuzG3hVPLWhQrQitjxlMjaiWygoysQA/Aq0FOTceyV+mXOf0cx/cDU4uMh+s81Wygnc18xXrGx
	jDumsK0RUkf0Mm0CpLklIGdaoh8f/Y8pvBMKiGExnzQHQTQh6jPn2SUb9M94V5e4WrCiLagfKmbMY
	O1qpKmJK8S/+W+AS300zyfhgRl0Hl1rQ34KpKpUOdphtUO1otKz5mUk0PuXTXYAY1tm+2pDJAzrZn
	t+2ELzCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE6ph-00000001VVm-1PWm;
	Wed, 29 Oct 2025 14:07:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE6pe-00000001VUQ-1hRa
	for linux-um@lists.infradead.org;
	Wed, 29 Oct 2025 14:07:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jbDiRc1txlZTTk//UC1k3FW4pC0DVEyDhtcenS6QTzU=;
	t=1761746842; x=1762956442; b=RnZwIs4PNZ3PZwUVKJ83697t2o+14V0yQeLRP6yq0mCwade
	rlnpVTjrs26AxgWAikmh3KoLJ4jGBmgm+cZ1HygcPkE91jp2VWi6/JVQ6xPWJX9BGwJuNJI+GbS6y
	AFWfQ79VxLlaO8jkCg3FicUXH0OOdkrqsbK/2dLwt5ts8I6OZunCKLCWpNJ19NHiX0ynQcMIwBFTk
	bCNOW8nbOnKOvI/TdT5Wcar1QEAQ1B2owNpHraJMTZNorUd54uLcVqVMMyaXSf+OxKxnvJP9Uy9gW
	QjyXNakiNUgSp7xncyiKMN24w5uuVemhFjSqCmrt8YbhDOxkTPFlwluaVqdr/4fg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vE6pV-0000000EkWX-0O7N;
	Wed, 29 Oct 2025 15:07:13 +0100
Message-ID: <516b490d30be6d0676ffe3be5942954bc3c08a39.camel@sipsolutions.net>
Subject: Re: [PATCH v3 09/12] um: use nolibc for the --showconfig
 implementation
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, kernel test robot <lkp@intel.com>, Arnaldo
 Carvalho de Melo	 <acme@redhat.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 29 Oct 2025 15:07:12 +0100
In-Reply-To: <99359472-8b1e-4d51-adb8-5b16f1f90a9f@weissschuh.net>
References: <aNaNtI+mbyc4zgFy@rli9-mobl>
	 <99359472-8b1e-4d51-adb8-5b16f1f90a9f@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_070722_444067_E8ADD693 
X-CRM114-Status: GOOD (  20.33  )
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

Hi Thomas,

On Mon, 2025-10-20 at 17:21 +0300, Thomas Wei=C3=9Fschuh wrote:
> Hi Benjamin,
>=20
> Sep 26, 2025 15:57:43 kernel test robot <lkp@intel.com>:
>=20
> > kernel test robot noticed the following build warnings:
> >=20
> > [auto build test WARNING on uml/next]
> > [also build test WARNING on uml/fixes shuah-kselftest/next shuah-
> > kselftest/fixes linus/master v6.17-rc7 next-20250925]
> > [If your patch is applied to the wrong git tree, kindly drop us a
> > note.
> > And when submitting patch, we suggest to use '--base' as documented
> > in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >=20
> > url:=C2=A0=C2=A0=C2=A0
> > https://github.com/intel-lab-lkp/linux/commits/Benjamin-Berg/tools-comp=
iler-h-fix-__used-definition/20250924-222547
> > base:=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux=C2=A0next
> > patch link:=C2=A0=C2=A0=C2=A0
> > https://lore.kernel.org/r/20250924142059.527768-10-benjamin%40sipsoluti=
ons.net
> > patch subject: [PATCH v3 09/12] um: use nolibc for the --showconfig
> > implementation
> > :::::: branch date: 2 days ago
> > :::::: commit date: 2 days ago
> > config: um-randconfig-r111-20250926
> > (https://download.01.org/0day-ci/archive/20250926/202509261452.g5pe
> > aXCc-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=3D1 build):
> > (https://download.01.org/0day-ci/archive/20250926/202509261452.g5pe
> > aXCc-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a
> > new version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/r/202509261452.g5peaXCc-lkp@intel.com/
> >=20
> > sparse warnings: (new ones prefixed by >>)
> > =C2=A0=C2=A0 command-line: note: in included file (through
> > tools/include/nolibc/nolibc.h, tools/include/nolibc/stddef.h,
> > arch/um/include/shared/user.h, builtin):
> > > > tools/include/nolibc/sys.h:109:29: sparse: sparse: Using plain
> > > > integer as NULL pointer
> > =C2=A0=C2=A0unistd.h:70:30: sparse: sparse: Using plain integer as NULL
> > pointer
> > =C2=A0=C2=A0 tools/include/nolibc/unistd.h:70:33: sparse: sparse: Using=
 plain
> > integer as NULL pointer
>=20
> Do you intend to work on your UML with nolibc patches this cycle?
> If not I would fix these sparse warnings in the nolibc tree and also
> apply your nolibc patches.

We are not in a hurry for the UML part and while it shouldn't be too
much work, I obviously didn't get around to it in the last week.

So, feel free to pull the patches in via your tree. Then I'll submit
the UML part again in the next cycle.

Benjamin

