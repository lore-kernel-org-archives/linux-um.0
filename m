Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8715CA5FA2
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 17:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=guBIp/MekqgsDqeDd2Xw/zLYREGmvAdkTYR9qnoypqI=; b=LRKxBnxGh+9hJCFnNLR9t/j4LL
	F0BioaUFKRI24iZBPSnPDhmHE8Lk7qUNReJ93FIRfb3CJNcdd7BQjMqQc2Q87xSY8hFOzNwAjkYQb
	QPY6010U4Fk6dSB2P19QsnDHwvtYzjPBW+8DQYp9OFoIsx5epkOGVl/IWR3eTqCVhafh+hO6wPCnN
	4Juhmxu7CzDhdSbpSgNAG04Qg+qmuKfSjR8qQqtUe5IATH+FL7KkRI2YXPJQRFXjmvf+DTwm34j1S
	m5T11YNU7Qh9mv0mB1qeBZkD0JR+GSkWUHtZ1dt6XpFWd/YaJzq4LrbPBk/S542t+LzpxK8xwMYyL
	BbVUuhbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF8v-00000001A80-1QP8;
	Mon, 28 Sep 2026 17:27:57 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF8s-00000001A5a-1bat
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 17:27:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 875281F395;
	Mon, 28 Sep 2026 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790616466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guBIp/MekqgsDqeDd2Xw/zLYREGmvAdkTYR9qnoypqI=;
	b=W5ZR3y/UdcRpQS0PZCZkghVkuVElx097d0aBev8USfGNMFEOF1irnZ3mpys7Jpy+ua6u46
	fFiwPlP1+UmFrv1VNWUFtrmJEZe+DUm9Z0mtWEy+Ro0PFpACmPpEjaZ76lifgX3MqDgSbM
	j0aAALaaVB1Bb7UPeijkYMSosi+06Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790616466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guBIp/MekqgsDqeDd2Xw/zLYREGmvAdkTYR9qnoypqI=;
	b=oCI6kHOTjkdfX5dInGF9/hhrbb52rZEnpDE/YdrUihhwn2jmvkDZhCvK22BTpmyrJgyCc2
	nhA8BGCzFI7ie7BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XzOmBuHn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rixRATj3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790616462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guBIp/MekqgsDqeDd2Xw/zLYREGmvAdkTYR9qnoypqI=;
	b=XzOmBuHnz1Ot5O5sEILn+MWugqpyAKKA/PCh+EhcwYncrpZBRTmTLjZC5OQgF/1Ev3/Gso
	+/PeGzxhdsQ2KG3N4y/CBO2u98VcOxUU70gWnUDbvR6kCt25UO5W3EZ+KnQrfX6zwMDTVB
	R7x6Ugt8TMIJYoLCqBYnZfs8JfefT5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790616462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guBIp/MekqgsDqeDd2Xw/zLYREGmvAdkTYR9qnoypqI=;
	b=rixRATj3Rna+JImNWmorIAkHsvgLdkUUJALiBEPJGYOCI0ojzzukqp+GnrKpBOBDwJuYu8
	Y3WUojCV7JVeMmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0DA1133F1;
	Mon, 28 Sep 2026 17:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nfsNJoyjumpmOQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 28 Sep 2026 17:27:40 +0000
Date: Mon, 28 Sep 2026 18:27:39 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-mm@kvack.org, liam@infradead.org, rbm@suse.com, 
	akpm@linux-foundation.org, luto@amacapital.net, brendan.jackman@linux.dev, david@kernel.org, 
	liuhangbin@gmail.com, corbet@lwn.net, kees@kernel.org, ljs@kernel.org, 
	broonie@kernel.org, mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, 
	surenb@google.com, vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, geert@linux-m68k.org, 
	daniel@thingy.jp
Subject: Re: [PATCH v3 1/3] selftests: kselftest: avoid cd - in runner
Message-ID: <arqi6iwLDDBlk6Tm@pedro-suse.tail5790ac.ts.net>
References: <20260926010819.604346-1-thehajime@gmail.com>
 <20260926010819.604346-2-thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926010819.604346-2-thehajime@gmail.com>
X-Rspamd-Queue-Id: 875281F395
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,infradead.org,suse.com,linux-foundation.org,amacapital.net,linux.dev,kernel.org,gmail.com,lwn.net,google.com,chromium.org,vger.kernel.org,lists.infradead.org,linux-m68k.org,thingy.jp];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_102754_572053_520C5ADD 
X-CRM114-Status: GOOD (  12.73  )
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

On Sat, Sep 26, 2026 at 10:08:17AM +0900, Hajime Tazaki wrote:
> The kselftest runner currently uses `cd -` to restore its working
> directory after running a test.
> 
> This is not supported by the minimal BusyBox hush shell used by some
> NOMMU targets. Store the original directory explicitly and restore it
> with a quoted path instead.
> 
> This also avoids printing the directory change performed by `cd -` and
> handles paths containing whitespace correctly.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Brendan Jackman <brendan.jackman@linux.dev>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: "Ricardo B. Marliere" <rbm@suse.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>

NACK.

https://pubs.opengroup.org/onlinepubs/009695099/utilities/cd.html

-
When a hyphen is used as the operand, this shall be equivalent to the command:
cd "$OLDPWD" && pwd

which changes to the previous working directory and then writes its name.


If you're running selftests on !POSIX compliant shells, that's a
you-issue. Fix the shell, or use something decent.


-- 
Pedro

