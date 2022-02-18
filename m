Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nL4li-00Evcs-JP
 for linux-um@lists.infradead.org; Fri, 18 Feb 2022 15:02:00 +0000
Received: by mail-qv1-xf33.google.com with SMTP id c14so15190477qvl.12
 for <linux-um@lists.infradead.org>; Fri, 18 Feb 2022 07:01:56 -0800 (PST)
Date: Fri, 18 Feb 2022 11:01:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 4/4] kunit: tool: Disable broken options for --alltests
Message-ID: <20220218150151.GD1037534@ziepe.ca>
References: <20220218075727.2737623-1-davidgow@google.com>
 <20220218075727.2737623-5-davidgow@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220218075727.2737623-5-davidgow@google.com>
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
To: David Gow <davidgow@google.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org, felix.kuehling@amd.com, linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 03:57:27PM +0800, David Gow wrote:
> There are a number of Kconfig options which break compilation under UML with
> allyesconfig.  As kunit_tool's --alltests option is based on allyesconfig and
> UML, we need to update the list of broken options to make --alltests build
> again.
> 
> Note that, while this does build again, it still segfaults on startup,
> so more work remains to be done.
> 
> They are:
> - CONFIG_VFIO_PCI: Needs ioport_map/ioport_unmap.
> - CONFIG_INFINIBAND_RDMAVT: Needs cpuinfo_x86 and __copy_user_nocache

It doesn't make sense to patch qib and then turn this option off, it
is required to build qib.

Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

