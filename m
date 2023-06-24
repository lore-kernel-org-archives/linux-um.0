Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD33EB64DA
	for <linux-um@archiver.kernel.org>; Sat, 24 Jun 2023 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UIK3lLmNqgETthAn8Nr3ZIPdj9MfRorNSI0dPyc3ev0=; b=gOyAhwG+t65gZ3
	GsRF96+GyLCLguXBD18R0qPzgSOJ3nv47f5M/G8+fxKPg6UGIcT3Bn5HGornP+UoJdpkl4AcJJPlY
	CCx0resN3TDvF5w+eCkJX/i9JMtlkQjE8T96tg8dXrDOvU6Tnd+AyrkLr7sDjzkO+LTleqEB7CO+6
	5+1tT3N8cXJVQg0Auj8PO9Xw0MdNk/dMLc4XN7JE6n1KlrK6ts1GL+TnA7mPEH9ytIpd3QtsEbgfI
	Ys6sHXmupl7iP80D8+zjCS3h8/KYaJCVnzSL7Hk/fXgx50v1y5SGLF4sQe8I350nDYUWTps3dN2g8
	kB8oG2lcuMb2DuWg3hiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qD37Q-00618C-0U;
	Sat, 24 Jun 2023 13:16:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qD37M-00616u-0P
	for linux-um@lists.infradead.org;
	Sat, 24 Jun 2023 13:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/T1ZWFGoI3wG8TTA5fyZDzaURz2CKEyx45+KZEvtO8c=;
	t=1687612549; x=1688822149; b=OLiwOT9L72K7V3XdKAWxhK/zsLmn2X6a+t3mqMhDwq71W6X
	FOaNEUUefwKnHed3VbHke/v1XljxAn3ugi0ZvIY9etCDF8FnWCdJPuB5Kc3WYJbulQwplsYWcbCzJ
	8L1t67HvPQKVlfd1A7QGNRWig2pNHcmkuqoFuLw/aP1XZ/5h/1mwODUgSK50IJArhte8KhIgveJTl
	ogFn39b5aevfjbpW5eQLpBYRQ3WzFZHHwx/cttDoY+VtV2kyWZ/tTGbc37men94dGOiKpPggGyCzg
	f5v0+ET838WFtBHtxWaRUD2Q5BTmER6FqrV6i+DFM1qrjn92bEDhwswbN6w/7kkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qD371-00Gfqq-1T;
	Sat, 24 Jun 2023 15:15:35 +0200
Message-ID: <ef180d8f1b69b95b51d324e0631807aeb6bcd09d.camel@sipsolutions.net>
Subject: Re: UML for arm64
From: Johannes Berg <johannes@sipsolutions.net>
To: Rob Herring <robh@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov
	 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Sat, 24 Jun 2023 15:15:34 +0200
In-Reply-To: <CAL_JsqKTb4QQGj6z2LB9tNFpwCRg5avdK=oQ7qzMjw1oWNBrvw@mail.gmail.com>
References: <20230622192247.GA2278576-robh@kernel.org>
	 <dc5704a5d452f7432313170ed900975b2b72354f.camel@sipsolutions.net>
	 <69707b721698594f96899c050871bcbb3594a9a1.camel@sipsolutions.net>
	 <CAL_JsqKTb4QQGj6z2LB9tNFpwCRg5avdK=oQ7qzMjw1oWNBrvw@mail.gmail.com>
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230624_061557_062917_27BFC5DF 
X-CRM114-Status: GOOD (  24.06  )
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

On Fri, 2023-06-23 at 16:34 -0600, Rob Herring wrote:
> 
> > 
> > Either way, the old patchset will give you a good idea about how it all
> > works, the changes are mostly in the details. I am happy to push out a
> > new version sooner rather than later if it might help with any efforts
> > on your side.
> 
> From a quick scan, it looks like there's some cleanups in the series
> which would be helpful without seccomp parts. One of the initial
> issues I've found is UML using older ptrace interfaces which arm64
> doesn't implement. PTRACE_GETREGS for example.
> 

I don't think that completely gets rid of PTRACE_GETREGS though, and if
I remember correctly, we really kind of need that there?

Though then again it's all been a while, and I only faulted the seccomp
mode back in in discussions with Benjamin. Looks like we've found a
potentially nicer way to make it secure than his secret-based approach,
and in fact in a way that should even make it SMP-safe, at least in
theory, obviously a lot of infrastructure is missing to make it SMP in
the first place.

Currently, UML has a host process per VMA. Obviously, you need multiple
host processes for SMP (to get SMP), i.e. one per (used) CPU per VMA,
with CLONE_VM.

The problem with the secrets-based approach here for SMP is that the
secret will be readable to the other running in the VMA (1) and then can
be used for circumventing the protection by jumping into the stub area
and calling host syscalls, see
https://patchwork.ozlabs.org/project/linux-um/patch/20221122100759.208290-28-benjamin@sipsolutions.net/
and
https://patchwork.ozlabs.org/project/linux-um/patch/20221122100759.208290-24-benjamin@sipsolutions.net/


Now the new idea we came up with is this: We can make the per-CPU VMA
with CLONE_VM but *not* CLONE_FILES. Then, in the stub, when we need to
execute some real host syscalls on behalf of the child, we

 * send the FD over in a message
 * use the FD for mmap (and also always use mmap instead of mprotect)
 * close the FD

Without CLONE_FILES, another thread cannot "steal" the (real, host) FD,
it's useless in the other thread. Note that I'm talking about host FDs
here, in-UML FDs are just numbers and it works all differently, I'm just
talking about executing host syscalls inside the VMA, to set up the VMA
correctly etc.

The BPF program now allows any the relevant syscalls (2) inside the stub
area, but since you don't have the FD unless you actually executed the
recvmsg() call at the beginning of the stub you can't do anything with
that by jumping into the stub.

There are some other details involved such as having to split the stub
data into a read-only "what to execute" (3) and a writeable "results"
page, but those are reasonably easy to deal with.

At the end of the stub, of course the FD must be closed. This is fine
though since mappings persist after the FD was closed. On the next page
fault we have to do it all again, but yeah, page faults were always
super expensive in UML ...

johannes


(1) unless you extract it directly out of the BPF program into registers
via some magic syscalls that get a BPF return, but that's kind of icky
too

(2) mmap & munmap are the most relevant ones, some others but they're
not that critical for security; notably mprotect is not allowed but must
be done with mmap instead

(3) so another thread can't actually overwrite the instructions of what
the kernel wants to run inside the VMA process from another thread while
it's happening

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
