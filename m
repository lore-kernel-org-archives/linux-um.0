Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJufZ-006Nim-DA
 for linux-um@lists.infradead.org; Wed, 10 Mar 2021 08:58:22 +0000
Message-ID: <82649fa88c2583bb82f5ddd236d7e4b5a859e4e1.camel@sipsolutions.net>
Subject: Re: [PATCH] uml: remove unneeded variable 'ret'
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 10 Mar 2021 09:58:01 +0100
In-Reply-To: <1615366148-5357-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1615366148-5357-1-git-send-email-yang.lee@linux.alibaba.com>
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
To: Yang Li <yang.lee@linux.alibaba.com>, jdike@addtoit.com
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, 2021-03-10 at 16:49 +0800, Yang Li wrote:
> Fix the following coccicheck warning:
> ./arch/um/drivers/hostaudio_kern.c:125:10-14: Unneeded variable: "mask".
> Return "0" on line 131

Word of caution to you:

You've already managed to be in various people's block list due to
sending patches such as

https://lore.kernel.org/linuxppc-dev/1614243417-48556-1-git-send-email-yang.lee@linux.alibaba.com/


You might want to stop for a while, and *really* carefully look at each
and every patch you send out.


In this case, you messed up the subject.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

