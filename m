Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mixQk-00BCTi-KO
 for linux-um@lists.infradead.org; Fri, 05 Nov 2021 11:30:48 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2] um: use swap() to make code cleaner
Date: Fri, 5 Nov 2021 11:30:40 +0000
Message-ID: <e392bf23c3ae4b93b1ffb23e40728873@AcuMS.aculab.com>
References: <7f95e669-fba3-32e6-cdb9-41fb415b3b82@cambridgegreys.com>
 <80d5d60030f9f4c0d299e139597f67c562f1d6b2.1636092427.git.yang.guang5@zte.com.cn>
In-Reply-To: <80d5d60030f9f4c0d299e139597f67c562f1d6b2.1636092427.git.yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Language: en-US
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
To: 'Yang Guang' <davidcomponentone@gmail.com>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>
Cc: "jdike@addtoit.com" <jdike@addtoit.com>, "johannes.berg@intel.com" <johannes.berg@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "richard@nod.at" <richard@nod.at>, "yang.guang5@zte.com.cn" <yang.guang5@zte.com.cn>, "zealci@zte.com.cn" <zealci@zte.com.cn>

From: Yang Guang
> Sent: 05 November 2021 06:19
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.

Is there any real point to any of these patches??

If I'm reading a 'random' piece of code I now have to assume
that swap() is something that 'magically' exchanges two items.
This requires more brain-power than parsing the three lines
that do an actual swap.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

