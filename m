Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84E0C4167B
	for <linux-um@archiver.kernel.org>; Mon,  4 Dec 2023 10:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nW8Z5m5bh3cNM81N3rj+G3+VMFppcIIbSZzfhji3ATs=; b=AtK+ki/Edkb87j08hW5tCHG4w9
	iVABKGdzNOQmzhwkCwzMA74ml/Fr9cKstPGTUReA9kvAbJ2FM6H6Egzscc2vUUkP0wfguk4zmwWR8
	JcJCflD7cuIQ2FYRY253uB4xRj7HxPoJwVVwdRfyjEDdQ/A5SStkFbqc19vv9Gr2gbdebmGcp0wgQ
	AhU59Ls1TvRv3XiEI2BJ9CibFXz76MajJNb6aNSLSy5DZ6JWx/s1BBrMzvLN6+0iEE31Z5f+IWmRj
	TBwVdisA8XWlkNr1YPPDQQ6jl2Z1LExL7xiXroHQOEqwqbMT5r5u9br/6yoZw2+oJf2zLAXnb8lzs
	u9NsNDuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6J7-003YL4-0G;
	Mon, 04 Dec 2023 10:36:09 +0000
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6Iz-003YJa-0U
	for linux-um@lists.infradead.org;
	Mon, 04 Dec 2023 10:36:08 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1701686153; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Iuxyr47FgIPs02ssKk4KoI7TW3FM27FlCpHhlLwFOTE1VqovOvMCRxgpl+L8YLtXDD
    WZN4kw1xVbENqT27dTU3J52ugv5m9y15/VwgyPHDITCgOMp1j+1V7jx1HLK0duNUurd2
    gSC3DFIoHvXktfkfkv2D/oOwcFrz22ABQ11o7tEXS34IjweOnbJVx1yk90+xlk4PvKrG
    9lm5BVGmY/JKmQ5yirpD+JvBK6yUyoWggYUzOaCgF4PcHN9T1sPIu58RL/oxVP2coBrE
    1uF0cfesdN59FsPqhvCUYXGc914NNDh/fcQQFS1h2vZ3umluTC9C1GWnL7EUKPGAsUDH
    snFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701686153;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nW8Z5m5bh3cNM81N3rj+G3+VMFppcIIbSZzfhji3ATs=;
    b=rshiPZfXhh3eH/73OMxP2RhFuybOA7fLv10ZoVUmOPCc5ETHK5kxCySFR0Dut0h8hU
    JNSw/vFJxZrljrODTSza/0QbSOnKEg1Oi6NbTzfqAyDdKIxnSCC4kW0XSAmQeWLc38XP
    JB/b2rdZCJxIxyv47G5e+uKj7vAZ6hciMHGncXqO6G7BoatgOV/hPojhvXizt+E5vpmn
    p2RS2EqerwvHZ3awUo47fuqqfbfdW2lBD8smlkLZG28beXgpVBvwlSiTdiHeiwJjsFRX
    t6CfmVsPxIbLXygd8wNkUuopFfzCzIwYyBsCzPAntmjnPQxITDrQrbpX/h8RejR7jJWb
    oMaA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701686153;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nW8Z5m5bh3cNM81N3rj+G3+VMFppcIIbSZzfhji3ATs=;
    b=WROvKzdyHgLUT/cipqxBF4ePHvD3cUqpgCR+HOgSaA5iLpK+9N1QxmaX8aqf7uVNnc
    t5MEiUX5ERg8Kx2BdqexrtRB8QdaJ0r12PTEUC+BuTntXU9G8lxdzuS8y6G0Mspg2JHX
    Sb0CWV963UFfKTYRGG2YU8PLXVuWEz17njvJ3P1/27f61YyEcS9fGGeoY37jqNcPSteV
    UBP1jZuMjfJhPgOSxljbZj6sw5fDFMjXtWC/vOEu79LWipAodOov/XQroXjfTCqpEBdX
    smfl8lpbGRiLXarkSIZuSDYfs5wPrOjLUPKMihFpZRyJaEgTr/mu+Uf80YRR891kowi3
    5mjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701686153;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nW8Z5m5bh3cNM81N3rj+G3+VMFppcIIbSZzfhji3ATs=;
    b=Wox73u9YXVdc8sWAeXgg4d+4VoxjXn50JCpiGZ59WaRJh/fdtQaE7tHkA4kd80K60v
    UtaRwj4FFSD16d7EADAQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9y2gdNk2TvDz0d0u1qzE="
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 49.9.7 AUTH)
    with ESMTPSA id jc800bzB4AZqHS3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 4 Dec 2023 11:35:52 +0100 (CET)
From: Stephan Mueller <smueller@chronox.de>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
 linux-um@lists.infradead.org, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-crypto@vger.kernel.org
Subject: Re: jitterentropy vs. simulation
Date: Mon, 04 Dec 2023 11:35:52 +0100
Message-ID: <4603694.2J7E7teO9M@tauon.chronox.de>
In-Reply-To: <e863c5fd47d6b4c36a8f4554d4470ad92e51abea.camel@sipsolutions.net>
References: <e4800de3138d3987d9f3c68310fcd9f3abc7a366.camel@sipsolutions.net>
 <1947100.kdQGY1vKdC@tauon.chronox.de>
 <e863c5fd47d6b4c36a8f4554d4470ad92e51abea.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_023601_551861_102A54CE 
X-CRM114-Status: UNSURE (   7.93  )
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

Am Montag, 4. Dezember 2023, 11:24:25 CET schrieb Johannes Berg:

Hi Johannes,

> 
> Well it _looks_ like it might be possible to get rid of it (see above),
> however, what I was really thinking is that jitter RNG might detect that
> it doesn't actually get any reasonable data and eventually give up,
> rather than looping indefinitely? It seems that might be useful more
> generally too?

Agreed. Let me have a close look at the patch then.

Thanks.

Ciao
Stephan



