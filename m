Return-Path: <david@fromorbit.com>
Date: Mon, 4 Apr 2022 19:26:55 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Build regressions/improvements in v5.18-rc1
Message-ID: <20220404092655.GR1544202@dread.disaster.area>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>, linux-rdma@vger.kernel.org, linux-um@lists.infradead.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-xfs@vger.kernel.org, alsa-devel@alsa-project.org, linux-s390@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Mon, Apr 04, 2022 at 10:16:08AM +0200, Geert Uytterhoeven wrote:
> On Mon, 4 Apr 2022, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v5.18-rc1[1] compared to v5.17[2].
> > 
> > Summarized:
> >  - build errors: +36/-15
> >  - build warnings: +5/-38
> > 
> > Happy fixing! ;-)

Well....

> >  + /kisskb/src/fs/xfs/xfs_buf.h: error: initializer element is not constant:  => 46:23

Looking at:

http://kisskb.ellerman.id.au/kisskb/buildresult/14714961/

The build error is:

/kisskb/src/fs/xfs/./xfs_trace.h:432:2: note: in expansion of macro 'TP_printk'
  TP_printk("dev %d:%d daddr 0x%llx bbcount 0x%x hold %d pincount %d "
  ^
/kisskb/src/fs/xfs/./xfs_trace.h:440:5: note: in expansion of macro '__print_flags'
     __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
     ^
/kisskb/src/fs/xfs/xfs_buf.h:67:4: note: in expansion of macro 'XBF_UNMAPPED'
  { XBF_UNMAPPED,  "UNMAPPED" }
    ^
/kisskb/src/fs/xfs/./xfs_trace.h:440:40: note: in expansion of macro 'XFS_BUF_FLAGS'
     __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
                                        ^
/kisskb/src/fs/xfs/./xfs_trace.h: In function 'trace_raw_output_xfs_buf_flags_class':
/kisskb/src/fs/xfs/xfs_buf.h:46:23: error: initializer element is not constant
 #define XBF_UNMAPPED  (1 << 31)/* do not map the buffer */

This doesn't make a whole lotta sense to me. It's blown up in a
tracepoint macro in XFS that was not changed at all in 5.18-rc1, nor
was any of the surrounding XFS code or contexts.  Perhaps something
outside XFS changed to cause this on these platforms?

Can you bisect this, please?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

