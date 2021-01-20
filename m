Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2HRG-0002xg-SD
 for linux-um@lists.infradead.org; Wed, 20 Jan 2021 17:38:48 +0000
Message-ID: <34643068c072c185cc9a65f2c3e643be5169136d.camel@sipsolutions.net>
Subject: Re: [PATCH v2] init/gcov: allow CONFIG_CONSTRUCTORS on UML to fix
 module gcov
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 20 Jan 2021 18:38:15 +0100
In-Reply-To: <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>
References: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
 <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
 <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>
MIME-Version: 1.0
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
To: Peter Oberparleiter <oberpar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>

On Wed, 2021-01-20 at 18:04 +0100, Peter Oberparleiter wrote:
> 
> > Tested with a kernel configured with CONFIG_GCOV_KERNEL, without
> > the patch nothing ever appears in /sys/kernel/debug/gcov/ (apart
> > from the reset file), and with it we get the files and they work.
> 
> Just to be sure: could you confirm that this test statement for UML also
> applies to v2, i.e. that it fixes the original problem you were seeing?

Yes, I tested this version too :)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

