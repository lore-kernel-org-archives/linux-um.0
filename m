Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329E9C25B10
	for <linux-um@archiver.kernel.org>; Mon, 13 May 2024 12:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=klDLt6cTPVK6ApU/9oChL0NQAOp316WjTDRHsPK3g+c=; b=XsOyg/l+xT9Jo5+DgP/E0aomD+
	Orrl83p3FoDDC4wlogZ4jb6yUspbk+EqhqwgCMPCRHZTt1TVsQosgAS4zPQf8UgLpDVRHz9fqQFNW
	ao+E1z54eli5B55ZC3+9FZsQlFanbDH+BCdKK3CmKufr8VhkDB7HVfBIXgkXmPlqZPwgkTXSpkHXX
	qvfiW5TuaI3CENHsH7L2YXKLYFQhFnhQpOTpSBFTf+9JA61kR3I3L1N2ChyteRWZBbdWqwss4f25P
	atcJq7rWZDepNNN1adabzWFRUbnHPtP2+SNApK5CKoBlifWB8XzfilOScbrouEEbXfkHg8D8NJsF5
	ITOvEKjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6UoY-0000000Cp42-1IDc;
	Mon, 13 May 2024 12:29:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6UoV-0000000Cp3G-3lxn
	for linux-um@lists.infradead.org;
	Mon, 13 May 2024 12:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=klDLt6cTPVK6ApU/9oChL0NQAOp316WjTDRHsPK3g+c=;
	t=1715603392; x=1716812992; b=jKC2+28pN3n8lLHrp3oYtlFlJsTb3FRTkQXBPTF525E06ae
	47do4iD44kWNR4gzwzcXzf9TF0roa2Gx1kMGqNQ0jLm7CQNry+hwbpFUZpmcoC7tNhFpaBN2duoBf
	SAfuNLUVj6SYv259JW3pxoUEHQtPxp4BLIk+jT2QKLsFwFWD65WaeUyAysQMAq7ESSChsLalzn6JD
	T0ACMRc11711//9ys2pEoGgHy+1TfWKbp8WBu2lc7B4SOZ8DaDMlU2oeaLv3LMkU5GQnfB6obheCt
	huNLZ5oUUbOl+fRghSsIKR4JYbsDBTwM32VWeXSptK2cNBTKnc5ojEcsmuWBye8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s6Uo9-00000002G9H-0idr;
	Mon, 13 May 2024 14:29:33 +0200
Message-ID: <d4f4666bf745e83ea00b466b7a7cfb5132b8c7b9.camel@sipsolutions.net>
Subject: Re: [PATCH] arch/x86/um: Disable UBSAN sanitization
From: Johannes Berg <johannes@sipsolutions.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org,  zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 13 May 2024 14:29:31 +0200
In-Reply-To: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
References: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_052956_170764_69547F27 
X-CRM114-Status: UNSURE (   5.12  )
X-CRM114-Notice: Please train this message.
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

On Mon, 2024-05-13 at 14:27 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Disable UBSAN sanitization on UML, since UML does not support it.
>=20

Luckily, that isn't actually true, nor does it actually do this at all.
Please fix the commit message.

johannes

