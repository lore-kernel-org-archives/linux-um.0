Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from imap1.codethink.co.uk ([176.9.8.82])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXWcT-0005ng-GW
 for linux-um@lists.infradead.org; Wed, 20 Nov 2019 20:30:35 +0000
Message-ID: <fff201b0d21a8ba775eb1d201e083ba96f8ff6f1.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 12/16] hostfs: pass 64-bit timestamps to/from
 user space
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Wed, 20 Nov 2019 20:30:22 +0000
In-Reply-To: <20191108213257.3097633-13-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
 <20191108213257.3097633-13-arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Colin Ian King <colin.king@canonical.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Fri, 2019-11-08 at 22:32 +0100, Arnd Bergmann wrote:
> The use of 'struct timespec' is deprecated in the kernel, so we
> want to avoid the conversions from/to the proper timespec64
> structure.
> 
> On the user space side, we have a 'struct timespec' that is defined
> by the C library and that will be incompatible with the kernel's
> view on 32-bit architectures once they move to a 64-bit time_t,
> breaking the shared binary layout of hostfs_iattr and hostfs_stat.
> 
> This changes the two structures to use a new hostfs_timespec structure
> with fixed 64-bit seconds/nanoseconds for passing the timestamps
> between hostfs_kern.c and hostfs_user.c. With a new enough user
> space side, this will allow timestamps beyond year 2038.
[...]

The "user-space" side has a structure assignment in set_attr():

	if (attrs->ia_valid & (HOSTFS_ATTR_ATIME | HOSTFS_ATTR_MTIME)) {
		err = stat_file(file, &st, fd);
		attrs->ia_atime = st.atime;
		attrs->ia_mtime = st.mtime;
		if (err != 0)
			return err;
	}

which will also need to be updated for this type change.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

