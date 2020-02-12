Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1osL-00060W-8m
 for linux-um@lists.infradead.org; Wed, 12 Feb 2020 10:04:10 +0000
Date: Wed, 12 Feb 2020 12:03:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] um: Don't use console_drivers directly
Message-ID: <20200212100332.GO10400@smile.fi.intel.com>
References: <20200212095919.80295-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212095919.80295-1-andriy.shevchenko@linux.intel.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: Thomas Meyer <thomas@m3y3r.de>

On Wed, Feb 12, 2020 at 11:59:19AM +0200, Andy Shevchenko wrote:
> console_drivers is kind of (semi-)private variable to the console code.
> Direct use of it make us stuck with it being exported here and there.
> Reduce use of console_drivers by replacing it with for_each_console().

Oops, this one is wrong, v2 has been sent.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

