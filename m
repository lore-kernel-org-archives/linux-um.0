Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BCAC83F1A
	for <linux-um@archiver.kernel.org>; Fri, 11 Jul 2025 07:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ra1U+fzVDe7M4uT8MutQD29pg0KXZ26WfxTeYcaTSEQ=; b=gVqOxSvaoS5IaM/2nmZue4MlbJ
	YKx+ijXzhlN7aQVNjqAjp519c3RGxvEgXG58YtomQWjVhdtvHHI44xmSrazFYOlkf+QP2Duaq7Liy
	cPIe9/3JFCgERFhVwXqHPFzIjvnashGgczJG+KToQgyk6mG+5IU02VlFJgZkITtr/EHgy+67kN9pF
	UcLS8bc6oQwJu78OwwaoBfxteoqsQP3eggJruvW8NH8ZsTEFRE5BmkTLbxJjNA7urKBzo+LlApegK
	OrdKLJVgatT4gu1U9CtkidGYCnqzNK6kJQMEWHbbBHN8Ftq5kUWuWrcUK4DFYqpC4E3SpIu4rp5hh
	oaqOHCjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua7nL-0000000DuLF-3P3u;
	Fri, 11 Jul 2025 07:03:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua7nJ-0000000DuKq-2B0H
	for linux-um@lists.infradead.org;
	Fri, 11 Jul 2025 07:03:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ra1U+fzVDe7M4uT8MutQD29pg0KXZ26WfxTeYcaTSEQ=;
	t=1752217421; x=1753427021; b=HM/kJ3/xVh8YAig7ZCaVBfJT04mIygfjy213ok3MVi0fwzz
	3qI7MvwngAC94/337MG42zXJpnRedPTrXoLk6bbozD0zm5MZzJRhro3CdZ5aT3ZlQgOvYg/aW5XED
	uK1HLdPZZCmpnsrmqKeZkjfu91hp4RvzEH6IUa2WfYxVP8orbFOwZFAeA761UVNHfkyELQjFu1yhU
	JUZU3eCOKwQKRgkdH+4vvVGZFLEAtdn32aXJKoVVeGlC2jCLEajyqxGBY7AglJD60S2hO+V2lU2Zc
	nrii7wYC6GiPVzrYvJHrKN7gNTwdZnmrLEUg2Uw34siJeuzqXf22zrT7dfbgyPKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ua7n8-0000000Fxfx-2z2U;
	Fri, 11 Jul 2025 09:03:31 +0200
Message-ID: <7dec916560a07a6d9d3f8e37bae482738d2c360c.camel@sipsolutions.net>
Subject: Re: [PATCH v2 3/3] um: Stop tracking stub's PID via userspace_pid[]
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, tiwei.btw@antgroup.com
Date: Fri, 11 Jul 2025 09:03:26 +0200
In-Reply-To: <20250711065021.2535362-4-tiwei.bie@linux.dev> (sfid-20250711_085106_929511_67CD6311)
References: <20250711065021.2535362-1-tiwei.bie@linux.dev>
	 <20250711065021.2535362-4-tiwei.bie@linux.dev>
	 (sfid-20250711_085106_929511_67CD6311)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_000341_555060_DB8CC604 
X-CRM114-Status: GOOD (  15.27  )
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

On Fri, 2025-07-11 at 14:50 +0800, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>=20
> The PID of the stub process can be obtained from current_mm_id().
> There is no need to track it via userspace_pid[]. Stop doing that
> to simplify the code.

So that is really obvious cleanups, and I can go apply them on that
grounds, but I started wondering if we're not separately being
inconsistent here, which perhaps didn't matter due to non-SMP:

>  #define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *old, struct mm_struct *=
new)
>  {
> -	/*
> -	 * This is called by fs/exec.c and sys_unshare()
> -	 * when the new ->mm is used for the first time.
> -	 */
> -	__switch_mm(&new->context.id);
>  }

This is now empty, so I wondered if we can just remove it _entirely_.

But the generic version calls switch_mm():
=20
>  static inline void switch_mm(struct mm_struct *prev, struct mm_struct *n=
ext,=20
> @@ -28,11 +23,9 @@ static inline void switch_mm(struct mm_struct *prev, s=
truct mm_struct *next,
>  {
>  	unsigned cpu =3D smp_processor_id();
> =20
> -	if(prev !=3D next){
> +	if (prev !=3D next) {
>  		cpumask_clear_cpu(cpu, mm_cpumask(prev));
>  		cpumask_set_cpu(cpu, mm_cpumask(next));
> -		if(next !=3D &init_mm)
> -			__switch_mm(&next->context.id);
>  	}
>  }

which plays with the CPU mask, but realistically being non-SMP the CPU
mask is never really used?

Certainly removing activate_mm() entirely seems to _work_, but of course
it never does anything since smp_processor_id() eventually is just
macros that expand to "0" (unless preempt debug is enabled). Any
thoughts?

johannes

