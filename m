Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAA9E77188
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 02:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6XxDgsDh63Hd8YUnQX8bX7YEs2+jNWGRYTJCUK51Cww=; b=F3dQZ1s+DKlfuSU2QqDJH79qJT
	d1+VU5aXJT95odpHC49EBaA0n/cBSJta4vsU1/xFKJUAeSU1l1KAtQl9g3CGU1EvOBZHfHfhvoyae
	FqR8SUP1h2EUqaiMzTQ2FMBqSK68fvAegjC7EEqRCCCC0X4yNFNE0iumX5yrGs91UrPUF4ix24tiV
	wmSMsns1BOR2DNwDZiEFzvqrULyiHo3vNIJqoMyW5cSXYewDh7XXZR3esQOiKyeOmmWJ3Duq77SWT
	JNHzZqvUw7NsfaXpw0c+UkPqzJx0mmql/W7u0KEZR/UV8LTyx6wv4ZiWfN/VvBm9m/hpmVfuD+mTm
	XD2HfHXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTX5i-0000000BtHa-2lmU;
	Fri, 03 Jan 2025 02:07:10 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTX4p-0000000Bt6m-09af
	for linux-um@lists.infradead.org;
	Fri, 03 Jan 2025 02:06:16 +0000
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-4361815b96cso78224975e9.1
        for <linux-um@lists.infradead.org>; Thu, 02 Jan 2025 18:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1735869973; x=1736474773; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6XxDgsDh63Hd8YUnQX8bX7YEs2+jNWGRYTJCUK51Cww=;
        b=OV/bSFUlYa1bYsI+VzAJ2nHrsqjwOjqg+VDXxashQmohgRl/yODC2wb1bCd+Bfp3Xd
         0sgyuMBhw6zJDF5P99x8KT9uvcVvYt2gwUcD3/lpZugMIp12HAgdvZHcETlIJ5o9tJMm
         /XKhLOOPFn76A9cGA72FO9Is6rjsZhgB5jJ7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869973; x=1736474773;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XxDgsDh63Hd8YUnQX8bX7YEs2+jNWGRYTJCUK51Cww=;
        b=JvKs28NKWP51NwwPxVMRhjGR1oJAimPzp72yDxZ5yuDqkBBU9hU0XvGrpsZj3AlQ7X
         SlBP5NascydLtwjO6TZOZ2ZNV51tZylgb3ASDdoN6s6lHJltousNFdz7ikB6TYxPFORi
         eX4kCYxoI/3d5jYTt0yV0DYIrpTx2x3iBleOzarBL0s0L0Wzq/HEzjHPkDVRzxkC9QPQ
         aBizb3fGu7LtB4tMeoOCToXQMGzL9ipnrYC67VNOMgMNxnKPT/yPOaqdojTiqzTp8HHy
         G7hmCJsmvTvjyXlAYRTmN5ZTGnmqZrM+Xa2jdk+MxJZup82NaiLiGlwZaGFFW7t5mrJE
         W1WA==
X-Forwarded-Encrypted: i=1; AJvYcCWTAt3WFdSYF9vtxQNrYLdrr8nGBl1pV53gVXNJSwBNVcrfD/oB6oG+cAO8759WZkmc78+AyMS2IA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzYrjih2auYCI1J8oWa3ZZl1EpdsTE8bJuKKwrdU78lj4VKkZpO
	8iU4PeCAxKW/zO+En/Qgr+AWZjTTTnzRekMmG2AfDuPoJO3OlKYI0asKkthYvtg=
X-Gm-Gg: ASbGncs+yWTFgkh+Z6tLVTqik3Ix/YKwXf2/XU0i6E++KZPJiz7gV7Fhj7MatC/P0gU
	oH2bt16wC9X4gvUq/8KteKl4edkshAPG4iWvnIK36e0pjYGOZNCDGRw4jplhKre5Qgx/j94JY2R
	9BCKM0UtX4r56NwocLSZMPE8+LyAmdU3spXftU+vFjye0q+jtUQwprgc9Bv2QtlX219Oz7ncFlJ
	vZ12+N7KCmMNzPf4xLIgj4IjJtQVA3LUhhjD+YHSPUvNljUlzW3umlc8DJiCKe2MTOXDD5b2iJS
	y2OmqTNcy9t1F5Uob8/3
X-Google-Smtp-Source: AGHT+IFX7s7OIdyOwqMqiHQ7Dij0fiev/6kDOgtgCa70BnwOXZiReSdRdJxFbmyfksFhQWRa5CI5/Q==
X-Received: by 2002:a05:600c:1c09:b0:434:9e46:5bc with SMTP id 5b1f17b1804b1-43668643750mr507478795e9.10.1735869972697;
        Thu, 02 Jan 2025 18:06:12 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm468771585e9.33.2025.01.02.18.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 18:06:12 -0800 (PST)
Message-ID: <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
Date: Fri, 3 Jan 2025 02:06:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lorenzo.stoakes@oracle.com
Cc: akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com, bp@alien8.de,
 brendan.higgins@linux.dev, da.gomez@samsung.com, danielt@kernel.org,
 dave.hansen@linux.intel.com, davidgow@google.com, dianders@chromium.org,
 hpa@zytor.com, jason.wessel@windriver.com, jikos@kernel.org,
 joe.lawrence@redhat.com, johannes@sipsolutions.net, jpoimboe@kernel.org,
 kgdb-bugreport@lists.sourceforge.net, kirill.shutemov@linux.intel.com,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, live-patching@vger.kernel.org,
 luto@kernel.org, mark.rutland@arm.com, mbenes@suse.cz, mcgrof@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
 petr.pavlu@suse.com, pmladek@suse.com, richard@nod.at, rmoar@google.com,
 rostedt@goodmis.org, rppt@kernel.org, samitolvanen@google.com,
 shuah@kernel.org, song@kernel.org, tglx@linutronix.de, x86@kernel.org,
 Juergen Gross <jgross@suse.com>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
References: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_180615_104392_E4272E24 
X-CRM114-Status: UNSURE (   7.88  )
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

> Hi Mike,
>
> This commit is making my intel box not boot in mm-unstable :>) I bisected it to
> this commit.

For what it's worth, we've found the same under Xen too.

There's one concrete bug in the series, failing to cope with the absence
of superpages (fix in
https://lore.kernel.org/xen-devel/6bb03333-74ca-4c2c-85a8-72549b85a5b4@suse.com/
but not formally posted yet AFAICT).

The rest of the thread then found a crash looking to be the same as
reported here, but you've made better progress narrowing it down than we
have.

~Andrew

