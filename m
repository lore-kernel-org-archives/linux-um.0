Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwSJi-0006I3-9j
 for linux-um@lists.infradead.org; Tue, 28 Jan 2020 14:58:15 +0000
Received: by mail-pf1-x442.google.com with SMTP id 2so6717108pfg.12
 for <linux-um@lists.infradead.org>; Tue, 28 Jan 2020 06:58:10 -0800 (PST)
Date: Tue, 28 Jan 2020 06:58:07 -0800
From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 4/5] ptp: 1588_clock_ines: add unspecified HAS_IOMEM
 dependency
Message-ID: <20200128145807.GA2492@localhost>
References: <20200127235356.122031-1-brendanhiggins@google.com>
 <20200127235356.122031-5-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200127235356.122031-5-brendanhiggins@google.com>
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: heidifahim@google.com, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, netdev@vger.kernel.org, anton.ivanov@cambridgegreys.com

On Mon, Jan 27, 2020 at 03:53:55PM -0800, Brendan Higgins wrote:
> Currently CONFIG_PTP_1588_CLOCK_INES=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
> 
> /usr/bin/ld: drivers/ptp/ptp_ines.o: in function `ines_ptp_ctrl_probe':
> drivers/ptp/ptp_ines.c:795: undefined reference to `devm_ioremap_resource'
> 
> Fix the build error by adding the unspecified dependency.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

