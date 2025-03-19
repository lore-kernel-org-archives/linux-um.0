Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7005C35FFA
	for <linux-um@archiver.kernel.org>; Wed, 19 Mar 2025 09:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DMVM2L1uU/YWWSlQPSXVfr5JFW50teu8FkOpCvXNEA0=; b=dj02m9tr+E41AHNBKuqUi4f6qN
	VAE+zasTLVDNuygdddxt/cO7klX1MSyiTRGvqzRBfdXzQNjvSy1UxnmTtRwpfQsHGj1dT2BbaAC87
	Q9HdXIbjYD5J+ZJRmVkoC4PBlnmXNMji4/pZmK+6d2MpB3NZlXJdaa5YLY7NX713fiuJ/2EOZP5pk
	EfAh4xKdtO05suExroO6bWCsghTUodt1eqNMW6tvNt1D63J52bWMSMzv7Wr2AhVUTV1U5kfOf2H34
	6LvlHBYlj2my1VwAVuLoLJsFqff38LGNcUpEwAA/DUROeV0CdgP8lp6pkcNqxsMmkwfkDYRSp4fx8
	vQybV8GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tupTJ-00000008RhI-15Xc;
	Wed, 19 Mar 2025 09:12:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tupSM-00000008RYn-0nMK
	for linux-um@lists.infradead.org;
	Wed, 19 Mar 2025 09:11:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DMVM2L1uU/YWWSlQPSXVfr5JFW50teu8FkOpCvXNEA0=;
	t=1742375481; x=1743585081; b=ULIhlx0dhNW3tPRJxyjNiwml+IYZFlTzJ9DdbKrBsyELxau
	/SvDhF98DUIKtbGZ54cEvo+mddZKvHOOm5ihujYoLQJClVI5KaaL5O7UsSVYKNj0QCykbS/VdJZNe
	vcOBgM9WBrv1MatKlSLjCuom8UYkHQ7FIMbRlfM6lVxNMjuCmGxNGuJd9pr0jsXdbPWQgipYPBKIa
	ErWNM8LsEWQgwZVqgLq/dQqCZhkesRbbUBl4Xe//zC+i3J4wEbMW93rNs2LEX0fhZgLyFEftQEGFt
	UKF9XoLuT5Q0VjimudqJxD8qCV6htxU1FS0Y+sLU5YqCIQHyogak92m+41J9inKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tupSI-0000000GGvT-3Fef;
	Wed, 19 Mar 2025 10:11:18 +0100
Message-ID: <91bdd4a1200950bf26d3cbe1a42cf1beb913a153.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/4] um: Add pthread-based helper support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
Date: Wed, 19 Mar 2025 10:11:18 +0100
In-Reply-To: <20250306150747.2926434-2-tiwei.btw@antgroup.com>
References: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
	 <20250306150747.2926434-2-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_021122_510789_9424F000 
X-CRM114-Status: GOOD (  13.03  )
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

On Thu, 2025-03-06 at 23:07 +0800, Tiwei Bie wrote:
> Introduce a new set of utility functions that can be used to create
> pthread-based helpers. Helper threads created in this way will ensure
> thread safety for errno while sharing the same memory space.

I'm not sure at the moment exactly what the issue is, but with the next
patch, I cannot shut down cleanly.

> +void os_kill_helper_thread(struct os_helper_thread *td)
> +{
> +	pthread_kill(td->handle, SIGKILL);

This ends up killing everything.

I thought maybe it's because all the signals are blocked:

> +int os_run_helper_thread(struct os_helper_thread **td_out,
> +			 void *(*routine)(void *), void *arg)
> +{
> [...]
> +	sigfillset(&sigset);
> +	if (sigprocmask(SIG_SETMASK, &sigset, &oset) < 0) {
> +		err =3D -errno;
> +		kfree(td);
> +		return err;
> +	}
> +
> +	err =3D pthread_create(&td->handle, NULL, routine, arg);

but removing SIGKILL from that set doesn't make a difference, and
perhaps this should be using pthread_sigmask(), e.g. if glibc doesn't
retrieve the values from the kernel but uses the ones last set by that
function?

Anyway, the issue is I cannot shut down, I get:

reboot: Power down
Killed

and the terminal isn't cleaned up, i.e. shutdown code isn't run.

Please check :)

johannes

