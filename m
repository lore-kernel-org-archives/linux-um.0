Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E278C5B543
	for <linux-um@archiver.kernel.org>; Tue, 10 Jun 2025 04:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIXPC+aHj2QXfaFWh+o02a9EiexMbX3RA+zC8JjqXGg=; b=vVhDqONUk/ZeulLzYeIMLAllEI
	6hb3X+F0Y28x1eVdFax9TF9mq2sUi9sMdCIPeJGFUw9OFCQqYmJbZuUu3aV22sU7yvLvX7RhSk8MY
	RUd9URfpVu3ly3fCfijuW3D4I0I1DjhOL2OGyHryardGvYsB11F6FIaBkKSwjYq5zMBeJRSgY6aXO
	9g1VFt8I+mDf9qOcGdWuiydkfviYQYD50neynSMXlLHCj8kMhEaMJ3VVYuq9iKfNYWqzuqi94jH9n
	OiW7834u8keiM2bf6ms/9RYGMBjsFDGBX78EJlfQWRBamh1K3+BNNzQ2f2AIe4Btg/pdnJ0Ok4PiH
	29ZK+jkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqOw-00000005jjd-0sdn;
	Tue, 10 Jun 2025 04:15:54 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqOt-00000005jim-2GDs
	for linux-um@lists.infradead.org;
	Tue, 10 Jun 2025 04:15:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 96DB3A50B25;
	Tue, 10 Jun 2025 04:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46203C4CEEF;
	Tue, 10 Jun 2025 04:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749528950;
	bh=SNmQMfX8br1v3m6Ue7itdaBLQ/yx3M1lD48sr4R/J6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+F7F0yEzPfqKL0TrqfMXXeklqTlnsG4CCmP4dKNRl9Cq90xxhD++itUyDG4aQGUs
	 oMbMIa8lR319QFWQKJFF+Ff5cvovzUnFjl2kxxRtcR14kY0ErFarqzjAtr2YysrCgP
	 lDsQIIcbIbTiA4L7sxUlfocSSMzsqE5CRdl7HcCrGcAUXCo9iSSzE+cxIy7jhu7Fbk
	 ksCbzd40NJDyFVpreicZuu8brXYtANRUAmwmV5ijt+pgR1fEP+/urR6o/TSUHsPUWL
	 gJgoDIX2tx0W4Jv+hUU4YdTejM2RWGtokspGoH7CuE020K2pV/K+jUDjsegEaoBFjg
	 q96OYf+YxJJyA==
Date: Mon, 9 Jun 2025 21:15:49 -0700
From: Kees Cook <kees@kernel.org>
To: Brahmajit Das <listout@listout.xyz>
Cc: linux-hardening@vger.kernel.org, justinstitt@google.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: Re: [RFC PATCH] um: replace deprecated strncpy with strscpy
Message-ID: <202506092114.01147457A5@keescook>
References: <20250607213006.7858-1-listout@listout.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607213006.7858-1-listout@listout.xyz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_211551_643966_333DFEEB 
X-CRM114-Status: GOOD (  11.56  )
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

On Sun, Jun 08, 2025 at 03:00:06AM +0530, Brahmajit Das wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This modification is mainly due to the concerns on
> https://github.com/KSPP/linux/issues/336, where it was mentioned that
> strncpy_from_user is confusingly named as it does not NUL-pad the
> destination, but it does NOT guarantee NUL-termination.
> With this approach/patch we can always ensure that the dst buffer is NUL
> terminated.

I think we need wholesale fix the kernel's usage of
strncpy_from_user()... first, how is it being used? Are things being
manually terminated? Are something destinations not actually C Strings?
We may want two APIs (like strtomem vs strscpy). And then since we're
dealing with user data, I would think padding should be included?

-- 
Kees Cook

