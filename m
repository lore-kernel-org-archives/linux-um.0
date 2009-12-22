Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1753125AbZLVLmp@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.1.10.0912212020450.19919@dr-wily.mit.edu>
References: <2b41c200912211621p72eceed5tb9f9711b2f96b72e@mail.gmail.com>
	 <alpine.DEB.1.10.0912211926100.19919@dr-wily.mit.edu>
	 <2b41c200912211639p30927d84k9253ac7c90ac0e68@mail.gmail.com>
	 <alpine.DEB.1.10.0912211944050.19919@dr-wily.mit.edu>
	 <2b41c200912211710m11f1ebbbjc3d30c67e9e49944@mail.gmail.com>
	 <alpine.DEB.1.10.0912212020450.19919@dr-wily.mit.edu>
Date: Tue, 22 Dec 2009 12:42:35 +0100
Message-ID: <2b41c200912220342i5ceade4bjba94615238cd872d@mail.gmail.com>
Subject: Re: [REGRESSION] um: CONFIG_STATIC_LINK=y broken
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Abbott <tabbott@ksplice.com>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2009/12/22, Tim Abbott <tabbott@ksplice.com>:
> Richard, can you test that this patch fixes the issue for you?

Using INIT_TEXT_SECTION(0) instead of INIT_TEXT_SECTION(PAGE_SIZE)
works fine here.
(Tested with 2.6.33-rc1 and 2.6.32)

//richard
