Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Sep 2010 14:42:15 -0700 (PDT)
Message-Id: <20100928.144215.246551852.davem@davemloft.net>
Subject: Re: {painfully BISECTED} Please revert f25c80a4b2:
 arch/um/drivers: remove duplicate structure field initialization
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100928212417.GF19804@ZenIV.linux.org.uk>
References: <AANLkTim85sH_2o=xCiDuoQrHq_7ZL96Y91xQMGxUP5Fy@mail.gmail.com>
	<20100928211106.GE19804@ZenIV.linux.org.uk>
	<20100928212417.GF19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, bharrosh@panasas.com, julia@diku.dk, akpm@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, shemminger@vyatta.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 28 Sep 2010 22:24:17 +0100

> Who maintains these drivers?

Your guess is as good as mine, which probably means there is no
active maintainer right now.

