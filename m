Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQBHV-00032B-S0
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 15:23:06 +0000
Message-ID: <011248b2ca9269e91386f230c0c13d80aaf5d7e3.camel@sipsolutions.net>
Subject: Re: [RFC v7 05/21] um: move arch/x86/um/os-Linux to tools/um/uml/
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 17:23:02 +0200
In-Reply-To: <451a47b488766c4bc67d69dacff3d6dbc01d0843.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
 <451a47b488766c4bc67d69dacff3d6dbc01d0843.1601960644.git.thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, retrage01@gmail.com, linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> Similar to arch/um/os-Linux code, arch/x86 also contains OS dependent
> part as well.  This patch moves underlying OS dependent part to tools/um
> directory so that arch/x86 code does not need to build host build
> facilities (e.g., libc).

Again, I don't agree with the rationale. This isn't a tool in the kernel
sense, and separating only by "what does it link against" doesn't make
much sense either.

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

