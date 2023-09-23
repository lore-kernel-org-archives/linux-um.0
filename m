Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D46CCE7A89
	for <linux-um@archiver.kernel.org>; Sat, 23 Sep 2023 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7ojkaOmffHM5OSf92g0A9Lh8XW6sOhji82sLh9qMRTA=; b=BLt/mRn4AUGTt+
	UPIeBLY0mrRI+FzuMI1rMFpkhhqhA8LbHRE67etfKX9qDBWKT4edew3b4uWuTnlGczG9orRtrfKnh
	nPI1cal9+VTQww3u+LKpDhAv9nHjBSNXEUyI+UjHHqPEMUWpAykZWKwmpgg2vRzReiaa7j/5nMBWv
	YD/yr2eCyedlpKfHtb1MOznEZYLHxRjg+eu0a+cJL7uLY6RehLkdCTMJ+0pgaxEr44I4EEapzm+nB
	TM61Nis5IZnVnIPt6yK4uN5JmjGQh/lMOzadnRBuWmMksmawUmX9i4Xd+nuQBGdPQWRfr2bR94nB5
	CpetCod/pehPRCKbL1HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qk8mC-00BPS4-00;
	Sat, 23 Sep 2023 19:58:52 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qk8m9-00BPRT-13
	for linux-um@lists.infradead.org;
	Sat, 23 Sep 2023 19:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KEYlYocwZZ4dhDm+H51hLgIgasyvYqPbwSXN6ZTA0ds=;
	t=1695499126; x=1696708726; b=uU8tf1RcSeyat21fcnStSJnGvPrGY/s2tD/+aGMDS5mbZPW
	3op0NZfDVZG1NufWmtmTy7fER6lLV1ejaUkxyABdMLBETqM7NuZStBYumnCmkUq7BnV2QC+uPwg/I
	LS2yBUahh2NOEOmpfJpD2FnvYSYFKXIMYGzCcrSNdRAi5kQDgRrliG1h7S6XDyf1EdVt5Iv4igeKS
	a7T16xpfwcd+X8180/UIMKORZSzigqwP7AkvKfp1D2tZJIA7oLw7OGsW43K7kLARLhk0pf07uDGqo
	GOe1D1G+KD5SSrskbvss9zia08ec1mZLBl7mEsdsFxC+y7vl82Wro0iUC/H8DIRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qk8m3-00068p-11;
	Sat, 23 Sep 2023 21:58:43 +0200
Message-ID: <e25f9511095858d313cbc85aef486b891e530a00.camel@sipsolutions.net>
Subject: Re: [PATCH] um: clean up mm creation
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Date: Sat, 23 Sep 2023 21:58:42 +0200
In-Reply-To: <44c606c0-c846-0bcb-0269-66974dee3c4b@cambridgegreys.com>
References: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
	 <88e0568b-6860-9042-7f8b-ab53edb4242e@cambridgegreys.com>
	 <ce18cec1dbacb366f2cf74ebc941c9fbc4b1e116.camel@sipsolutions.net>
	 <9cc73695-b3c7-d194-72e9-9bde142c81f8@cambridgegreys.com>
	 <6bc1a06d1b91b2badd388a4e13d467ed4eace651.camel@sipsolutions.net>
	 <44c606c0-c846-0bcb-0269-66974dee3c4b@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230923_125849_660344_AD730726 
X-CRM114-Status: UNSURE (   3.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sat, 2023-09-23 at 06:29 +0100, Anton Ivanov wrote:
> 
> One more thing. Is your find "real" /bin/find or busybox.

Yeah, definitely real find, it's my normal host system with hostfs after
all :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
