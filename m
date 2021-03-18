Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMnaW-004iLm-Lq
 for linux-um@lists.infradead.org; Thu, 18 Mar 2021 08:01:02 +0000
Message-ID: <0264c509792ed110ca47a7eeef16cbfa119dd320.camel@sipsolutions.net>
Subject: Re: [RFC v8 08/20] um: lkl: memory handling
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 18 Mar 2021 09:00:52 +0100
In-Reply-To: <m2zgz19v6y.wl-thehajime@gmail.com>
 (sfid-20210318_011203_531127_A4687028)
References: <cover.1611103406.git.thehajime@gmail.com>
 <19d4990f2ef77ad595248183071da5e43149931c.1611103406.git.thehajime@gmail.com>
 <03c74a353c87994b61450ba8086f1ccda40b2ea8.camel@sipsolutions.net>
 <m28s6nc2w1.wl-thehajime@gmail.com>
 <87933c0d6c07745b20f6724721e3bf2da8f67f72.camel@sipsolutions.net>
 <m2zgz19v6y.wl-thehajime@gmail.com> (sfid-20210318_011203_531127_A4687028)
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, retrage01@gmail.com

On Thu, 2021-03-18 at 09:12 +0900, Hajime Tazaki wrote:
> 
> sorry, I didn't get this line.  uml_kmalloc() is in kernel/mem.c but
> what is in os-Linux ?

Never mind, I was just confused.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

