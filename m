Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917A4C7EE2A
	for <linux-um@archiver.kernel.org>; Fri, 20 Jun 2025 16:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QRasoAf86UvMVNSfJDyTQbAWje5bM+KDr1G1hgdDfEs=; b=MjfsZYNgpaKgtEUGmWXoVQwNvZ
	BOZ0pSI2oo8Q8KuXewlEvgTvENCyTuzbLSodhFTwFMQGl6ZczRuBQ8ipVsnmpUUxDQ51oEeaOrkxQ
	LwyLngHoRE+hmb2tx49rYIN51OfTeHkCS2jgIZOtM+mbjZDZJqD+cDZraSq1zjVdK7TV3JucIGEJ+
	xXAVVALxUIZA7wUjP9Sl9Jg2yFBn08tKdSE1FR7uJQozBGhH2+9daFHSLjL+q9Hc1Yw7vmPYYDR0q
	yZoFhH4o+/9tN1D/HqFW0PFZ4ppPRKEFHlZfwZaDyNTphNu837B0NYs+JLhk1Tk/srYubH+l/nKJx
	22a0helg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSeO0-0000000G6r6-2c0L;
	Fri, 20 Jun 2025 16:14:40 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSdva-0000000G1vl-0TNS
	for linux-um@lists.infradead.org;
	Fri, 20 Jun 2025 15:45:19 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750434316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRasoAf86UvMVNSfJDyTQbAWje5bM+KDr1G1hgdDfEs=;
	b=HNJCi0Jd/ZLNOsQCSs/tAPCrfmflLF5AiXX3mwSEGz4cCYRZN6q/FhpOvb49AdmaBGvuHv
	Av3cHnDHDZTduSKOeQqFJ7cYMCN2eWwcmYdwPSDafQ3t1qu4s8i9ig13ZhrBRVxczOrrju
	7N0LHDXm88LCR7K9QGh7AuJsrZGW95ouYo2o7jJa/c3AlJPtza/EDNKODY86Do3I1aNum/
	qGWccPwOkhGInS8QsmQYadufeSmOz+DH0/mVC5U62ZbdBA9p0T4REbU9Yh99ywPGypcAA2
	2RFXBb2NkmCZPg8bZfxQylEPrkY8A7tjTUWXw3KbutCgKp1IgBRQU3jP+oYZSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750434316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRasoAf86UvMVNSfJDyTQbAWje5bM+KDr1G1hgdDfEs=;
	b=+D98VrXKw7IagiGrRJBS8PGYp+GEQTGnISyjliozgrXhhDELu8zjdPdSYVAP/Au+veoU3t
	l6wSABhaRK9NfVDg==
To: Petr Mladek <pmladek@suse.com>, Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Jason
 Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 linux-um@lists.infradead.org
Subject: Re: [PATCH 5/7] arch: um: kmsg_dump: Don't check for CON_ENABLED
In-Reply-To: <aFAdGas9yGB4zhqc@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-5-f427c743dda0@suse.com>
 <aFAdGas9yGB4zhqc@pathway.suse.cz>
Date: Fri, 20 Jun 2025 17:51:15 +0206
Message-ID: <84tt4aifhw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250620_084518_289941_1DFF26EC 
X-CRM114-Status: GOOD (  26.79  )
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

On 2025-06-16, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2025-06-06 23:53:47, Marcos Paulo de Souza wrote:
>> All consoles found on for_each_console are registered, meaning that all of
>> them are CON_ENABLED. The code tries to find an active console, so check if the
>> console is not suspended instead.
>> 
>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>> ---
>>  arch/um/kernel/kmsg_dump.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
>> index 4190211752726593dd2847f66efd9d3a61cea982..f3025b2a813453f479d720618c630bee135d4e08 100644
>> --- a/arch/um/kernel/kmsg_dump.c
>> +++ b/arch/um/kernel/kmsg_dump.c
>> @@ -31,7 +31,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>>  		 * expected to output the crash information.
>>  		 */
>>  		if (strcmp(con->name, "ttynull") != 0 &&
>> -		    (console_srcu_read_flags(con) & CON_ENABLED)) {
>> +		    (console_srcu_read_flags(con) & CON_SUSPENDED) == 0) {
>>  			break;
>
> I think that we should actually replace the check of the
> CON_ENABLE/CON_SUSPENDED flag with
>
> 		is_console_usable(con, console_srcu_read_flags(con), true)
>
> And it should be done at the beginning of the patchset before
> changing the semantic of the flags.
>
> Motivation:
>
> There is the following comment at the beginning of the function:
>
> 	/*
> 	 * If no consoles are available to output crash information, dump
> 	 * the kmsg buffer to stdout.
> 	 */
>
> The if-condition checks for:
>
>   + "ttynull" because this special console does not show any messages
>     by definition
>
>   + disabled/suspended consoles; note that this patchset is replacing
>     CON_ENABLED with CON_SUSPENDED flag because it the state is
>     changed during suspend.
>
> But it should check also for:
>
>   + whether the console is NBCON_console and does not have con->write_atomic
>     because such a console would not be able to show the messages
>     in panic().
>
> And it should also check the global "consoles_suspended" flag. Because
> consoles won't show anything when it is set.
>
> And all these is already done by "is_console_usable()" except for
> the check of "ttynull" which is very special.
>
> How does the sound, please?

FWIW, I agree with all these points.

John

