Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPAL3-0006ru-AM
 for linux-um@lists.infradead.org; Sun, 04 Oct 2020 20:10:34 +0000
Message-ID: <def18938e845a5db49764aee03bceff614a4e040.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Remove dead usage of TIF_IA32
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 04 Oct 2020 22:10:17 +0200
In-Reply-To: <20201004050436.1406738-1-krisman@collabora.com>
References: <20201004050436.1406738-1-krisman@collabora.com>
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
To: Gabriel Krisman Bertazi <krisman@collabora.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: kernel@collabora.com, linux-um@lists.infradead.org, oleg@redhat.com

On Sun, 2020-10-04 at 01:04 -0400, Gabriel Krisman Bertazi wrote:
> 
> Also, I think the variable clean up it performs is not needed as 64-bit
> UML doesn't run 32-bit binaries as far as I can tell

Yep, that's true. I was looking into it once _very_ briefly, but no :)

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

