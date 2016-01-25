Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1453760661-1444-8-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
	<1453760661-1444-8-git-send-email-richard@nod.at>
Date: Tue, 26 Jan 2016 00:33:27 +0100
Message-ID: <CAAtXAHe37n30eiN8t4i4zRUu6XAFHs98JhpBz0b4VDiy4Aa0yg@mail.gmail.com>
Subject: Re: [PATCH 07/22] fpga: Fix dependencies for !HAS_IOMEM archs
From: Moritz Fischer <moritz.fischer@ettus.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Alan Tull <atull@opensource.altera.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Jan 25, 2016 at 11:24 PM, Richard Weinberger <richard@nod.at> wrote:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: Moritz Fischer <moritz.fischer@ettus.com>

