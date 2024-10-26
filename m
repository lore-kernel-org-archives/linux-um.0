Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49D6D10BE8
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 07:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HbaKrFhcnQb7RukIJwDGiJhkFvHtc6dweIpzQ07MgGI=; b=avzRMsMlt0qGD2olAO8RXFCw5I
	vJkwotvVwEWtXKNy/UoDEtSHhAGzxnTGWKwhfQH2w0lWduSLpeOcRaMtzwfxaxUFXFtGvhNPWAYtd
	6QRiPkJ6phRrn4RoD6izwiEO/8uZG8zmyTI8O+rmN0pepc7qe/4w8gZVYhRiQwNoeEfoofWFxqibL
	ZtTFuqso8kxJTZG8bs8jUwRB3k7jEZxOI43tJGE/1JRqJK6QeHYPMCeafaLTKrn7KNIPRgYiAd7yo
	hwrcY8Yk2o4lN4Mda/DqgkdWNtpo2EARF+DBUM50ktH372KXiUt4qE2Ai4GGg/Y7i/PXXYhOLsXbb
	rUkmEQng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4biA-00000006BSD-2IpQ;
	Sat, 26 Oct 2024 07:59:50 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4bi8-00000006BRF-04ar
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 07:59:49 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so1846975b3a.1
        for <linux-um@lists.infradead.org>; Sat, 26 Oct 2024 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729929587; x=1730534387; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbaKrFhcnQb7RukIJwDGiJhkFvHtc6dweIpzQ07MgGI=;
        b=IZgUc5H8tptmPAa26KWDBmfoNfMqbVpq4kDXqPPILcCgnChk2nD2G0UGNnj8A6re54
         CxIfbnnEgcSbtBloik5kBc/+GgYI/D4bVj7eRmrKQO8HRqklAVFSl1X989WNmtIPCBFp
         AuTa7CqZZ24aX3D2ICDWoGxgpeQUohA6WtbuzoOAXNWPgt+dNkyt76s59b6ET/nthIm3
         yK3iySLOspjNOSsM1RGVR2jY6gda125MV07FUJCsHupr0hlu9t077nnSTLOS7IMiacDO
         C7gkaoyTNHf5XhUG0V2CbMJ9hyiiaLo3fYT0beIfVivBixyfK+CuGcn2rOoTzdaO5N66
         AWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729929587; x=1730534387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbaKrFhcnQb7RukIJwDGiJhkFvHtc6dweIpzQ07MgGI=;
        b=e6NhS56FFI9b8lxJMxTWv1jAnS9ig0yLo5QL6zAOV9MErQTLl82vwuUZ0+s2G91UbH
         pvc7LMcUrhF9GEnSGCty33CMF3FmMblml7EgPqqkZMkmUQ7V9Vdcz/iEFefmuU5sQSDT
         oAShQmGRhMdXYG7tzjNIlaV6CqfhDGzokjj0yihCyGwPRRsXbLeA496pLGrEgweX5DBg
         QSWxkxjzNJ8MQIBiQECX91peIRxkXFirRgsNyuLelLK2uuu9u+KGlJtOSJZ2fi868sGd
         mvkBa5KR2NDyFRmmQNUTcf/Auq0BjjP5dgBxj8V2Byhwlh68PQPBluXE2/uUU4AMpvg5
         3C2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9/ekz7LHWir3M6haODO3QNfvT2wxF4AbY05cqWqFJvy7s7xRNWoHzwNn+HwmKU8AecQXyclqHA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyvG7XGyiGOZ61STIAVhE5l4j8GtI7WgZrvc5kCBJBOvAbQA3zH
	d4DMTDMcIMG42Kzj3OX3m81vN80BFglT96mEe7ueO5NKFcCfY867
X-Google-Smtp-Source: AGHT+IGDp6fZt2IoTCsVxb5nAEKHF9XXJGg2zMtdzgC+M064lqUnqQzkBi35os5nK8pMYMKPa/ml9A==
X-Received: by 2002:a05:6a00:2e26:b0:71e:5573:8dcd with SMTP id d2e1a72fcca58-72062f1ed40mr3020826b3a.2.1729929586984;
        Sat, 26 Oct 2024 00:59:46 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921a94sm2265092b3a.8.2024.10.26.00.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 00:59:46 -0700 (PDT)
Date: Sat, 26 Oct 2024 20:59:40 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, kees@kernel.org,
	tiwei.btw@antgroup.com, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] um: Malloc just enough space for fitting pid file
Message-ID: <ZxyhbCw39rBzAvtg@mail.google.com>
References: <ZxxmLngMg3iNjOfK@mail.google.com>
 <cd892fb5436f1de0fa2ffc9c9ec229873227210f.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd892fb5436f1de0fa2ffc9c9ec229873227210f.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_005948_080207_E0B24672 
X-CRM114-Status: GOOD (  15.50  )
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

On Sat, Oct 26, 2024 at 09:44:53AM +0200, Johannes Berg wrote:

Hi!

> On Sat, 2024-10-26 at 16:46 +1300, Paulo Miguel Almeida wrote:
> > umid is already generated during make_umid_init __initcall so there is
> > no need to allocate UMID_LEN bytes to accommodate the max possible name
> > for the umid segment of the filepath
> > 
> > This patch replaces UMID_LEN occurences in which it's redundant
> 
> OK, I guess that's maybe all true, but can you say _why_ in the commit
> log?
> 
> johannes
> 

thanks for taking the time to review this patch. :-)

when I said that "umid is already generated during make_umid_init
__initcall", from my humble point of view, I was explaining the 'why'
using UMID_LEN for calculation buffer sizes was redundant. Then again,
once we know the size of char* umid, we can use strlen(umid) instead.

I'm happy to amend the commit message to a better one but I'm not
sure if I got 100% what I'm missing.

- Paulo

