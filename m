Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6917CC67861
	for <linux-um@archiver.kernel.org>; Fri,  5 Apr 2024 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oAuKDU6QiZ6ML3XGubjP2fNWyg1GAOwTBQh+lV89r38=; b=vc8ffUmwbD9DY4AixhFlta4xJ0
	i0fR54BJ5HIb2AU00pwLDTkSdw+7K1RQi+nZdOQ3aR89mO8p/uqyWVoa0keBLFGms6lvltR3ABlp+
	6/5LJSItGYNDNe/FaTfHtpqAzDluF3+nsqnYA5fXlml4rQ9GQ21Nab1kxC5LfUfzwj3ki+1rnTSqg
	9JDLnRStrjIeDGz+Zl2ImI0kkID4wqwenHiAZ2BjCvgXVWHK5w1EQ5UmA524xZmENdPVheRMHoDtV
	71QApbpl85QgoyRdomnOVcnfxlkEpEAvc7W/MWAIZH82xN+PMRMKW9O6efXMEL/Cqb18eA9lSiGt7
	X5tPOiIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsm6y-00000007vJH-0aU4;
	Fri, 05 Apr 2024 16:08:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsm6w-00000007vI7-0NEU
	for linux-um@bombadil.infradead.org;
	Fri, 05 Apr 2024 16:08:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oAuKDU6QiZ6ML3XGubjP2fNWyg1GAOwTBQh+lV89r38=; b=I5Y1PBc7y4vJhZyPGFOoluNd2H
	vRnzJJslJAaJM41gbDlVVwo7KbGiOvPcbIMtloFRo7pFJy4RXYnC2FnOntbs1LmHG1L9zyNtVD0zN
	Z52tkHa8e8tEM3lR6uCqCUBLbAKzSJPPS4y4hcqJjSqajPG3/OTbyjQLRUQGjg575OUrOPQ8c9RsD
	H8YcQ8FFjNewDtopSlpPP8jbd62Hb26ss2nMRszmgKgK9qix7HKCUKVuaHA4UVDLFYm0eSQO5/iLm
	VrCfPAMlYrr0Ssovr1xCQlCKv7H1xTy3GgUySBSoBircN5IXs4kjEVrM7IzJV5hTNz93ZVZpHp0DB
	qebtEfqg==;
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsm6s-00000005jHw-2R5H
	for linux-um@lists.infradead.org;
	Fri, 05 Apr 2024 16:08:12 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so47672139f.1
        for <linux-um@lists.infradead.org>; Fri, 05 Apr 2024 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712333283; x=1712938083; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAuKDU6QiZ6ML3XGubjP2fNWyg1GAOwTBQh+lV89r38=;
        b=gWbX93A3B+8okAUXr2UAHvVS/Pw9BPSwBqldhboyAs+fFxpdwknAxLAeRL2UsH+FUR
         mKa7dLWmT6lw1v+w6MvHNnplZxTaYg/TAokQcWFvX3T1H10YROWpq+y9h0tpTdK3B3mw
         +p3jOtd1vFfqqUALXbwsni6JbOfEepyNxM3sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333283; x=1712938083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAuKDU6QiZ6ML3XGubjP2fNWyg1GAOwTBQh+lV89r38=;
        b=TU2QlPjlTSQgv4LayGRBG4iwJnJSu/RH4zfLgBAlTBTtwxsWs3ypkxKcDtN6Usykt4
         PMS+T/xxu9FFZ6MTAo2rKbmdbVKz11+r+2CLH/QPfEspKA6BmOxyH0F/ayKeWnC5qUSR
         yDDvCBC8tN6kGeubscgkx34HjObZIynLN1g/q/+aacOubnIVerFta5DGfvPGT/S3Ox03
         eLOqcScYciqxT97HXfDpHdPV1ntkoYFSlfp4PqydgAc6jySoHHLpU0DpiYilm11e5Gxe
         Y2746SFzZvb5kZ9b3ZsN7cpsQrbk5cyX+txm9lIUnh8Eawr0JyHZ/b4bZqWwdzcGDFSI
         NCBA==
X-Forwarded-Encrypted: i=1; AJvYcCX3/8bcOZ02t1ehyS9RwpQ7e4sFlAH4WTeaRBtMfHiNMFcmneAJQwB2OWX7kdj0x6Epy1ROWapGI5IoG8XMSE07ZV+vpnU0VHgu1JRf
X-Gm-Message-State: AOJu0YyRK67Ykza4QMvBKVukkGQfs/AcjbpCe8PBvaI/ej8+84VOXcSD
	wyLdqoWfxjBZpVaxI794CnGc9QuI+pzrhAw1/AL40yZOnkKrI+DwtzIx6eZNpCk=
X-Google-Smtp-Source: AGHT+IEFSBlsclA6e2FP+b8IjmZLWOus+sNYfoqoIt8htlDfnprRT5+aCUKOtOxFEmmqkr93Xto/Bw==
X-Received: by 2002:a05:6602:148:b0:7d0:bd2b:43ba with SMTP id v8-20020a056602014800b007d0bd2b43bamr1795873iot.0.1712333282821;
        Fri, 05 Apr 2024 09:08:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f4-20020a5edf04000000b007cc78dafb96sm578949ioq.7.2024.04.05.09.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 09:08:02 -0700 (PDT)
Message-ID: <60d96894-a146-4ebb-b6d0-e1988a048c64@linuxfoundation.org>
Date: Fri, 5 Apr 2024 10:08:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Handle faults in KUnit tests
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 James Morris <jamorris@linux.microsoft.com>,
 Kees Cook <keescook@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marco Pagani <marpagan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Thara Gopinath <tgopinath@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Zahra Tarkhani <ztarkhani@microsoft.com>,
 kvm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 x86@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240326095118.126696-1-mic@digikod.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240326095118.126696-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_170810_762776_9B72E3E5 
X-CRM114-Status: UNSURE (   7.31  )
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

On 3/26/24 03:51, Mickaël Salaün wrote:
> Hi,
> 
> This patch series teaches KUnit to handle kthread faults as errors, and
> it brings a few related fixes and improvements.
> 
> Shuah, everything should be OK now, could you please merge this series?

Please cc linux-kselftest and kunit mailing lists. You got the world cc'ed
except for the important ones. :)

thanks,
-- Shuah

