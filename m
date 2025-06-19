Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52EAC7115A
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M+rlOSMwP5n/p31SLvploDk0T2daobV+1VIdpmncEK0=; b=f+pT4OGmeqfJ5Dj9ZhNvK/z6jO
	GMiRllX+encPFNc+bRhwYpRSkPRCKqUvAxBGyZbL8uFiMikizbHgmQreREv/jiEfE7bMQdFfWgwQp
	ff8LHqPw1UTsCCElwsI7xDoT8ShJ5EmNuXmc/aSBEmYl3fWtT24BMWnrbpZcmrKfc0QIzUluJs7fk
	mvt1BfMVcCzqUifbkstT8rqQZftRJqbLSRlSs37W9flNrWtuzqpsCjX8WzRacnSkwvkmXhmD8GY9W
	7HjZak6j93VZnoTqo9AV7FgNSECiyvH7M3PQD36U0kc3gqCA9t4N+caAwtcDnA/VF0T0Hm4EKBOwg
	BAx+7SEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSHVF-0000000DXCS-2s6y;
	Thu, 19 Jun 2025 15:48:37 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSEnz-0000000D6av-2M8c
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 12:55:48 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-236470b2dceso8116905ad.0
        for <linux-um@lists.infradead.org>; Thu, 19 Jun 2025 05:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750337747; x=1750942547; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+rlOSMwP5n/p31SLvploDk0T2daobV+1VIdpmncEK0=;
        b=Iq4tlMhhVkk0dNFrnEpmJXCYuHFvyuew7iA/XGIzYMM7T9zo3XbN1y5HS94RpahIp3
         Pdq/6EXZ2QY9Lv53lBDBVIatGw9pkx1jcNZ0Cs+7wr2TMKrS1iu4XuYOYdYBsValXRrn
         LxKCjBsSauEZ0jfLfP+awrtFfNSfSvajP7hOS9YLoHct4Wb8OP4Sl9Ty0naHp4flcpTU
         b175lK79edCTL23js4WtiRf5i/8PDI9Bs9x9o2cFWn8PzcXMs7cjcbe/Fmn7/Q+t4792
         UqfuBUBTEjGMx3403yJxu6LrqlMl6UEbG68aoSNSLztEvZHvxtW6uFB1JGxXe2AUecaE
         cnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750337747; x=1750942547;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+rlOSMwP5n/p31SLvploDk0T2daobV+1VIdpmncEK0=;
        b=loWVuLyWXJMfEMdGgf4YL6p+Qi56FngCb2SMxfAj3++p53Yen3y6YNqu7WGSj1d3yB
         TQnJxwNeYGKUg5KY2SqvEYLFardDqcelNrbpgDDVcpjWCJs1YhbYXW8AxhqKTx54vieH
         ocNB92Z39IypQ+HCsG53zmRAsVWxJvzYjgJGO/SXokGfE/+LxZOJOSWWYlxH4QNIEGzj
         gUqpOYoNFLoq9AVtvhy37QBQkXCbLxPeMPiGasB92MqiBRivN1taKrLOLo0EQNBh4cOD
         9f73grHYun7YjKw3RLXnVVDDq2IDf+pq0WP7AI8HZi4hQ0jYKaoR35VhPbOrcpAC+xQN
         9qUA==
X-Gm-Message-State: AOJu0Ywbl9pWvbXUSCmLZO+Zhso2fL21mYE2BKUWM59XNlM74hGcp7xF
	cWLaTwAGVVGmuSwQBNkO5xf9mmfo5vdDNV9SU/sKxxHXT2C5pb9uMnx1xsM/+7ph
X-Gm-Gg: ASbGncs+yssq82k744MRVinDtGVKhHFbb+t39gkXPOja2Lglaj5aVwsM/204iG1w41l
	60RFbhuX7+Xm6IWTn3XOur1jI6uygfJ7Op594YmuwFoXbejtMbresf389dNO79VZ92Y2Iblj+GE
	N7gtMA/CmPaN7Z+Bu8T+bKMY9jxGGmysbcTdfUjXTfD9+dJAJQ1OkZne8eVB6YX0MgX2QULgwxa
	YgyNu8OWFDZmeDDCQhtQQZKy7IOtALaaFA19H5papTAFxmAqvMZEZumbXHjPW2zQeqKlpX3ici1
	bUGpc/g5bJ05skEegqm4DFE/RuiqcrWb71FhBQj6VRZv7u3DNSHIauYUowYidQcCSmzFFudcpBC
	NhsuAOyJnQ/b0qF8w7UWCgcNyuPpTbjyq2Tp2c6POlrnzx6Ed
X-Google-Smtp-Source: AGHT+IH1EMoai3zHMb4zRC/VNByRbk72Z5RtT7pHk3Ocj6JqFBNF5Na0YBNCNAzeKpEwwxPk9Drpcg==
X-Received: by 2002:a17:902:d2c6:b0:234:aa98:7d3e with SMTP id d9443c01a7336-2366b3ad2famr342090745ad.29.1750337746613;
        Thu, 19 Jun 2025 05:55:46 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782b2sm119684905ad.111.2025.06.19.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:55:45 -0700 (PDT)
Date: Thu, 19 Jun 2025 21:55:42 +0900
Message-ID: <m27c176gc1.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v7 10/13] x86/um: nommu: signal handling
In-Reply-To: <a81b27bdf40fba54b28325bdb28f697c48a005d6.camel@sipsolutions.net>
References: <cover.1737348399.git.thehajime@gmail.com>
	<7714247990d673226ce0f42ca838d8ec338cf882.1737348400.git.thehajime@gmail.com>
	<a81b27bdf40fba54b28325bdb28f697c48a005d6.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_055547_600198_43D5AB7B 
X-CRM114-Status: GOOD (  13.47  )
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


Thanks,
# this is a thread of my older series, v7 (current one is v9), tho
your comment is still valid so, thanks !

On Thu, 19 Jun 2025 20:43:06 +0900,
Benjamin Berg wrote:
> 
> Hi,
> 
> I am not sure that fxsaveq/fxrstorq is guaranteed to be sufficient. I
> don't think that catches some of the newer AVX registers for example.

I've added fxsaveq/fxrstorq parts with your suggestion,
test-signal-restore.c.  I think I may not know all of userspace
situations with register usage so, my current approach is to address
each issue when we faced real issue with a concrete test case.

> At the same time, dealing with all that properly could be rather
> annoying. I don't really have a solution for that, normal UM does not
> need to deal with many of those details …

thanks for the input.
I'm also/always trying to study a lot from existing code base.

-- Hajime


