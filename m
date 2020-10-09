Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQuop-0000tw-5j
 for linux-um@lists.infradead.org; Fri, 09 Oct 2020 16:00:31 +0000
Message-ID: <bb9e774e3115078623cdbec12d1b05bc2fdd87d7.camel@sipsolutions.net>
Subject: Re: [RFC v7 06/21] scritps: um: suppress warnings if SRCARCH=um
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 09 Oct 2020 18:00:27 +0200
In-Reply-To: <m2tuv442wu.wl-thehajime@gmail.com>
 (sfid-20201009_031344_500332_274F29B0)
References: <cover.1601960644.git.thehajime@gmail.com>
 <e994b27b4732a21a571cf09bd5071f583d85dd89.1601960644.git.thehajime@gmail.com>
 <5caf34d16a0f2816b47cd8712ca7d59e9733a815.camel@sipsolutions.net>
 <m2tuv442wu.wl-thehajime@gmail.com> (sfid-20201009_031344_500332_274F29B0)
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
Cc: linux-arch@vger.kernel.org, tavi.purdila@gmail.com, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, retrage01@gmail.com, linux-kernel-library@freelists.org, anton.ivanov@cambridgegreys.com

On Fri, 2020-10-09 at 10:13 +0900, Hajime Tazaki wrote:
> 
> > and maybe only when actually building for NOMMU/LKL?
> 
> The standalone UML doesn't use the headers_install.sh script (AFAIK),
> so I think this would be okay.

Yes, I was more thinking in terms of documenting the purpose in the
code, similar really to the argument I made elsewhere about "NOMMU" vs
"LKL mode".

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

