Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A833C61DC6
	for <linux-um@archiver.kernel.org>; Thu, 27 Aug 2026 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvXjJRXBUzQTXjIk2SBQORZUK73WXX7PK6h6g7xXJSg=; b=m/M+wowBiUT9k/iE1aQjNZGB1y
	PC/lc2p9wmOC6xBLZeEk3eJzLQ/ytRIPrU6VfdMXydxWmDqS5mX7af4+Ti8O5A2uTWcY/avvrheWp
	Cppgc0AyM4/xLvPhCj5z9sTFdGd1/HFDVHH8GloRqoX+JZ2u/XTOWpfbdmYapEKNAUatJnEIYj3cW
	x265xpjg2/Kn0tbZKAd5PUeHszWmQSVjoR5UduE1doUYVa3xwcfDMeDpVUCLW9uXbLPhJ53N2P3VO
	1FEWWEakyHtCbHfk8X765dtb6f/18Q3hJ4sElRwfCeKY22K/GVe0vRJBOMDxnVjmEkBHQvxaSyk/t
	vbVHu5cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzZ0l-00000003wUR-0nih;
	Thu, 27 Aug 2026 12:15:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzZ0j-00000003wUK-2gKQ
	for linux-um@lists.infradead.org;
	Thu, 27 Aug 2026 12:15:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 089FC600D3;
	Thu, 27 Aug 2026 12:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEDA1F000E9;
	Thu, 27 Aug 2026 12:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832912;
	bh=OvXjJRXBUzQTXjIk2SBQORZUK73WXX7PK6h6g7xXJSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RUzQMoxJkpxyCoz0a2/sLQb1IVLhrCUgiaTIeCnSk4MWC9vT3OEIh8jCRWE4mCcgT
	 xnM9Bcwe4KEkZBsGphkk5RUH1kzegvjvo1HDSXewtMd9o6eTJylWendZlZM72Kg3DX
	 4lq0tFfubJiZtt92Hk/W4kd6dS+CbRK5DmhGbnrIy2uRedQmdeKPojrlkvu1GgdBYy
	 ttbhgX3KLVczbvuZX9rR/FcBg1vHg3gfmFuhD7xIyVeCtDUjX8BHEeq8Fyp08gepDK
	 X5DUVWEiG+hLMau2NQqaPgkN1vQvCKidO3SzXwSfQxTwpM1GJ++7IwnNfEgCrypvQi
	 7G8z+2aoh45yw==
Date: Thu, 27 Aug 2026 13:15:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: ljs@kernel.org, linux-mm@kvack.org, liam@infradead.org, rbm@suse.com,
	akpm@linux-foundation.org, luto@amacapital.net,
	brendan.jackman@linux.dev, david@kernel.org, liuhangbin@gmail.com,
	corbet@lwn.net, kees@kernel.org, mhocko@suse.com, rppt@kernel.org,
	shuah@kernel.org, surenb@google.com, vbabka@kernel.org,
	wad@chromium.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org,
	geert@linux-m68k.org, daniel@thingy.jp
Subject: Re: [PATCH v2 1/2] selftests: run tests on nommu architecture
Message-ID: <28939864-7a8a-4204-bf68-b53e77200f35@sirena.org.uk>
References: <20260825015945.141739-1-thehajime@gmail.com>
 <20260825015945.141739-2-thehajime@gmail.com>
 <ao2aTD1ZGObPfp4T@gremlin>
 <m2zey8ufh0.wl-thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mrf2Wb1b1zm1oMZI"
Content-Disposition: inline
In-Reply-To: <m2zey8ufh0.wl-thehajime@gmail.com>
X-Cookie: Alimony is the high cost of leaving.
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


--mrf2Wb1b1zm1oMZI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2026 at 05:36:59PM +0900, Hajime Tazaki wrote:
> Lorenzo Stoakes (ARM) wrote:

> > >  		esac
> > > -		cd - >/dev/null
> > > +		cd "$OLDDIR" >/dev/null

> > Hmm, why are you changing this bit?

> on nommu we cannot use /bin/bash (i.e., no fork(2) so, we use
> /bin/hash, a busybox-offered shell with vfork.
> with this `cd -` (standards specified) isn't implemented due to slim
> requirement of that shell (I suppose, miserable...).

> thus this workaround.

It'd probably be good to have this as a separate commit with a changelog
explaining what's going on, it'll make review easier if nothing else.

--mrf2Wb1b1zm1oMZI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqQKkgACgkQJNaLcl1U
h9BXfAf9HIKrY3R1ifWbdQiCchDNja2ZvlJvk7WjJkdSkjVHJpNUyYWBr7iNXldP
uqe6h3Lxz5A01ehepxZw9SUHN3KJ7lFEKu4+nL1Mad5Ilj/fxLocolyYhzyo7sff
9rNiCZgNo7MTu3Fo469kifhj4gTzmkOVFmruROcRqHnsfEkRFA5jl0QG3SgGP+43
vlVLBlc3hLG9gmxOvnC3D5a3U2WdKvn35p8ZFZGp2zGSH0sAqNda1cx6tKul6r+k
zjOxyuuOwW4JjgUoBbRTXgyUziM/UFEYpffTFZ2fVH6rtOeS6cwJaCoAJ8xR2N/8
VpL8PDYd1CYUFKaaQFzI+zEMB095gQ==
=Em/s
-----END PGP SIGNATURE-----

--mrf2Wb1b1zm1oMZI--

