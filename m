Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0F7C64ED8
	for <linux-um@archiver.kernel.org>; Thu, 23 Feb 2023 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bkOyNwOp9FULRdo51uTn7eDMsWKC88lJeMl9uQfafZk=; b=o2Njb1F+HWWZky
	g58EKGauT6ESyjfcoDpEcUkAmu3ULAmKfZdpzQsIuy5GyLylpNGszwIcORw34OajFQy/Da5PPkh/Q
	o/DOJD5Kb+shRuNWfYGc45n0QyHrk0wAMsUdFhVfwoHB/d+CPmeSMYB1RHPTnuaQKdJ8N3HKx9gCw
	N1BXfBLI5d7aNULPJYHtYfwb1JfwOK9VnNv4oZE1XldgXPNtbM89V0tfBBp5SE9w+nBg+tMZoZ3pg
	1MXiJ1kZJ+IeCwD3oRPiJX00jyMQcTJrcvEYoh10+lMaVrBXvguX3iDdZgpnBsDMsMa566vu1BGk5
	Wy48QvUhn/iTNqufhmWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVIul-000MKp-Sr; Thu, 23 Feb 2023 21:14:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVIui-000MKF-U8
	for linux-um@lists.infradead.org; Thu, 23 Feb 2023 21:14:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 65978617A8;
	Thu, 23 Feb 2023 21:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5107DC433D2;
	Thu, 23 Feb 2023 21:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1677186843;
	bh=MUhUqx7vVGAnxY5zruGpqZ5Pgz60Ct8/k1u12vDjbB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vr/NHquQcar3bzTBEBn18RM6nlYOT2OfmkLSV0rpGdT9H0K3qFFFTstH8jfO1Xfor
	 PP4ypsuevUPYWyWM5cW9FBu9DMxOKMIgyoGRTBoJCzTfhiQ+UwWEr/ar88eAaAVfw9
	 E2HQa7TJiVTR84KhzRqvyO3sQ6NnIhZgCZQmXwWE=
Date: Thu, 23 Feb 2023 13:14:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Glenn Washburn <development@efficientek.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-um
 <linux-um@lists.infradead.org>, Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
 <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Message-Id: <20230223131402.6d6a662f76348b14574121d3@linux-foundation.org>
In-Reply-To: <cover.1676532759.git.development@efficientek.com>
References: <cover.1676532759.git.development@efficientek.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230223_131405_035937_F58FC7C5 
X-CRM114-Status: GOOD (  12.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 17 Feb 2023 19:11:52 -0600 Glenn Washburn <development@efficientek.com> wrote:

> Added suggestions from Jan.
> 
> Glenn
> 
> Glenn Washburn (2):
>   scripts/gdb: Correct indentation in get_current_task
>   scripts/gdb: Support getting current task struct in UML
> 

For some reason I get a bunch of rejects when applying these on top of
the latest patchpile.  Please check my end result:

def get_current_task(cpu):
    task_ptr_type = task_type.get_type().pointer()

    if utils.is_target_arch("x86"):
        if gdb.lookup_global_symbol("cpu_tasks"):
            # This is a UML kernel, which stores the current task
            # differently than other x86 sub architectures
            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
            return var_ptr.dereference()
        else:
            var_ptr = gdb.parse_and_eval("&current_task")
            return per_cpu(var_ptr, cpu).dereference()
    elif utils.is_target_arch("aarch64"):
        current_task_addr = gdb.parse_and_eval("$SP_EL0")
        if((current_task_addr >> 63) != 0):
            current_task = current_task_addr.cast(task_ptr_type)
            return current_task.dereference()
        else:
            raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
                                "while running in userspace(EL0)")
    else:
        raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                           "supported with this arch")




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
