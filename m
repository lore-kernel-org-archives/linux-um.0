Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJDCn-00GTFF-7W
 for linux-um@lists.infradead.org; Mon, 08 Mar 2021 10:33:43 +0000
Message-ID: <ad507487a9181b1ef2771d0c965aa0d49af43dc9.camel@sipsolutions.net>
Subject: Re: Bug#983379: [PATCH] um: mark all kernel symbols as local
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 08 Mar 2021 11:33:32 +0100
In-Reply-To: <358bce016384468722ba5cf42d2b5ae8650868e6.camel@debian.org>
 (sfid-20210308_112923_852002_C82CA2D5)
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <20210305214315.75ea78f93d79.I410acf4509c4ff51aac4a03df61d19abfa0454cb@changeid>
 <5d04179e-5ba5-a0cc-e514-c90feea5eb00@cambridgegreys.com>
 <161406935658.1350056.9530002632452194106.reportbug@beast>
 <ca04eca09e65939f1b828b7572c91e9cb2046b4b.camel@debian.org>
 <358bce016384468722ba5cf42d2b5ae8650868e6.camel@debian.org>
 (sfid-20210308_112923_852002_C82CA2D5)
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
To: rrs@debian.org, 983379@bugs.debian.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: Christopher Obbard <chris.obbard@collabora.com>

On Mon, 2021-03-08 at 15:59 +0530, Ritesh Raj Sarraf wrote:
> Hi,
> 
> Just a follow-up question on this fix.
> 
> Is it something that is a candidate for linux-stable ?

I guess that makes sense. Once it's in mainline you can also request
that yourself :)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

