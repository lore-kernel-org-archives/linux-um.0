Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF7AC02198
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 10:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6qQSUzHgCyxJavo98b2ypHiPRZXpN9/8Rj9BOTux8BQ=; b=TUkYhfpDfOJAMjxRzuQHVCWPX9
	CaO4F6WjZrGQeMTGgNbxOoVEnNGCa/OCXxSA0Sdn7zNbrKC1F1lMxrprX2Uh7QLQxnKShGzGpQbDz
	oIItV4QwvQPqsXmFGTscm7q7ww/ms5D+9//F679PjR+hZ0K2SMP1KjP+d7+S0CsQQrZcPICN+x5xN
	kkSOrIhgRozPiNP9qJQBwPOmapEyCmbgI8uvKR7av/Y/dauZfQQAcPKY8zsfCbHQRq0bn5Gqfrbsw
	GnibF7+D9wn945t7mG+Vf2jFqC8s2faDkGO8MY6uRwV7eiTlaULorWbJ3DC8xP2dghuKCEWx3m3Qd
	JHRCwZsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkKzc-00000007nYv-0gk3;
	Tue, 18 Feb 2025 10:38:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkKti-00000007loT-1iwF
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 10:32:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6qQSUzHgCyxJavo98b2ypHiPRZXpN9/8Rj9BOTux8BQ=;
	b=Y861E9qHfSDuSSfMHWV4ucsl5YMkDhjAsxVxgHHSlSzUGPFlmB7GGAstUXTBhF7VfRGGcb
	6D4ENnERYCetZfdpWw/O1OG3XjpEjCmQiW0xB7P7wTyu4eLTOzEe3ZC9OOip7noMox2Xtf
	VVg4DpsKU02nnCjqktON/4m6mXVluwY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-b9AqueCOMGS8RiP72q_p2g-1; Tue, 18 Feb 2025 05:32:11 -0500
X-MC-Unique: b9AqueCOMGS8RiP72q_p2g-1
X-Mimecast-MFC-AGG-ID: b9AqueCOMGS8RiP72q_p2g_1739874730
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f45a86efdso1056805f8f.2
        for <linux-um@lists.infradead.org>; Tue, 18 Feb 2025 02:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874730; x=1740479530;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6qQSUzHgCyxJavo98b2ypHiPRZXpN9/8Rj9BOTux8BQ=;
        b=VVPFZh1jOWRiFOUzNCHDIEbpTi7Sz9atj6SHEZ0oex5M798e9L3li0JAw3Ce9sr/cE
         ldL1oGLlPYb6cq0ddGYlcjvuROLTgAsgjXe5hJZezRZOSOAZeiATlSTnop8HFiziCDrW
         Vqe2nm2VeEHQGQgNLee9YbUuENcy1e6S0LLeqvB/EA730YcaS1q9pSfE6unO0gtkqnR3
         WCJq4kgVtVIVIkecz0Y3Rxdamu0T4mgB72/4+SmppXWr9QAxO5Rt7re3zWmQGC6r4An/
         P/GrQiQGRMLxO/2jA69MVBX7zI4LtaECOgTojwIY0g7qE4np3haw2rEtnr7HOBht0DiN
         np/w==
X-Forwarded-Encrypted: i=1; AJvYcCW3+iy3vTdy/nuARyq40MYP4WmFU5H1WesbZzjqB3FXwEF85wbSqCkRtt0Ja+LlTy8xTZxPptQmzw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzdXly8LoSA0dJpDCqcQZ1TH6r/zRIGc0XWgndTEkVhin5xUJSy
	ywqrLesLVwxlnP2sb2SoV+2xZDfxnv/LYqOU4lyo/+ytTCKE5CL5xYriViaxu15Dl3hDb6F78ju
	7caxmjakWYodKVsf3eB5f5BZolTy8OScpDPV3TOd/7WudiHIyUu93PsRcPWkV+g==
X-Gm-Gg: ASbGncvZUPOrB7FH06IStq6VCfMKVb9Y5Zje3VEA/UOB74HPudxfKnb3B/vJdEzGN6q
	mNjkvAJViFFTdv+sVIvo/PdcBuoKdNuZ8RrmgO+bMtuO6Co25NvaxkOIKubJjbQ1amDgx5Egz1l
	adNp8vSpuAxipwGblS1n9cJR5P+B0aghgRHzxeUxIlIWe1nklrtPm/6PJfAsbcuAuGXZ+AzW0hG
	w+mMNxstNUIhNps2WbQ6ZxzvO0Nz2Pwh1OsOtBcRzsKQHHFPB82BGr4SzUP/BDJVm2pbe896z3U
	MMJUXdoJf8sb6bzamlEFo1Ux6WiqW4/nsc1xPQBH1xoA9ktXrD3BerxdZArDzy53FNYDsX6dvtD
	j1SgKBwSp98GXG9aJ6iEjyFXjXvFlJC2p
X-Received: by 2002:a5d:5888:0:b0:38f:287a:43e2 with SMTP id ffacd0b85a97d-38f33f11a6amr10019560f8f.11.1739874729865;
        Tue, 18 Feb 2025 02:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHcoLtTGItTBQVw2jJchMRekN6vG0iQZFBlCtfZJTgat4RtCXNKhMX84MbQAT4tMgdFIp+iA==
X-Received: by 2002:a5d:5888:0:b0:38f:287a:43e2 with SMTP id ffacd0b85a97d-38f33f11a6amr10019525f8f.11.1739874729381;
        Tue, 18 Feb 2025 02:32:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d94acsm14844177f8f.75.2025.02.18.02.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:32:09 -0800 (PST)
Message-ID: <d3f1692f-3e80-495e-a39d-fc665732e0d6@redhat.com>
Date: Tue, 18 Feb 2025 11:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: Introduce a common definition of mk_pte()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-3-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217190836.435039-3-willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TLcnTy-b7X3nxtxhjCd9fbXs5B5kffIO94PeF3uoRg4_1739874730
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_023214_544278_E36698D3 
X-CRM114-Status: UNSURE (   6.71  )
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

On 17.02.25 20:08, Matthew Wilcox (Oracle) wrote:
> Most architectures simply call pfn_pte().  Centralise that as the normal
> definition and remove the definition of mk_pte() from the architectures
> which have either that exact definition or something similar.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


